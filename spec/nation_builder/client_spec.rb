# frozen_string_literal: true

require 'spec_helper'
require 'logger'
require 'stringio'

RSpec.describe NationBuilder::Client do
  subject(:client) { nb_client }

  it 'is built by NationBuilder.new' do
    expect(NationBuilder.new(hostname: 'x.nationbuilder.com', token: 't')).to be_a(described_class)
  end

  it 'sends the token as a bearer header and JSON-encodes bodies' do
    stub = stub_request(:put, 'https://test.nationbuilder.com/api/v1/people/add')
           .with(headers: { 'Authorization' => 'Bearer secret-token', 'Content-Type' => 'application/json' },
                 body: { 'person' => { 'email' => 'a@b.com' } })
           .to_return(status: 200, body: '{}', headers: { 'Content-Type' => 'application/json' })

    client.put('people/add', { 'person' => { 'email' => 'a@b.com' } })

    expect(stub).to have_been_requested
  end

  it 'parses JSON responses into plain hashes' do
    stub_nb(:get, 'people/1', body: { 'person' => { 'id' => 1 } })

    expect(client.get('people/1').body).to eq('person' => { 'id' => 1 })
  end

  describe 'instrumentation' do
    it 'reports the request with numeric IDs normalised' do
      calls = []
      stub_nb(:get, 'people/123/taggings', body: {})

      nb_client(instrumentation: ->(stats) { calls << stats }).get('people/123/taggings')

      expect(calls).to eq([{ path: 'people/_/taggings', request_type: :get }])
    end
  end

  describe 'logging' do
    it 'logs rate limit headers when a logger is given' do
      io = StringIO.new
      stub_nb(:get, 'tags', body: {}, headers: { 'X-RateLimit-Limit' => '100', 'X-RateLimit-Remaining' => '42' })

      nb_client(logger: Logger.new(io)).get('tags')

      expect(io.string).to include('limit=100 remaining=42')
    end
  end

  describe 'errors' do
    it 'raises RateLimitedError on 429' do
      stub_nb(:get, 'tags', status: 429, body: { 'code' => 'rate_limited' },
                            headers: { 'X-RateLimit-Limit' => '100', 'X-RateLimit-Remaining' => '0',
                                       'X-RateLimit-Reset' => '1483272000' })

      expect { client.get('tags') }.to raise_error(NationBuilder::RateLimitedError) { |e|
        expect(e.remaining).to eq('0')
        expect(e.reset_at).to eq(Time.at(1_483_272_000))
        expect(e.message).to include('rate limit')
      }
    end

    it 'raises RateLimitedError when the body code is rate_limited' do
      stub_nb(:get, 'tags', status: 403, body: { 'code' => 'rate_limited' })

      expect { client.get('tags') }.to raise_error(NationBuilder::RateLimitedError)
    end

    it 'raises ValidationError with the validation errors' do
      stub_nb(:put, 'people/add', status: 400,
                                  body: { 'code' => 'validation_failed', 'validation_errors' => ['email is invalid'] })

      expect { client.put('people/add', {}) }.to raise_error(NationBuilder::ValidationError) { |e|
        expect(e.errors).to eq(['email is invalid'])
        expect(e.status).to eq(400)
      }
    end

    it 'raises NotFoundError on 404' do
      stub_nb(:get, 'people/9', status: 404, body: { 'code' => 'not_found', 'message' => 'Record not found' })

      expect { client.get('people/9') }.to raise_error(NationBuilder::NotFoundError) { |e|
        expect(e.code).to eq('not_found')
      }
    end

    it 'raises Error for other failures, including non-JSON bodies' do
      stub_request(:get, 'https://test.nationbuilder.com/api/v1/tags').to_return(status: 502, body: 'Bad Gateway')

      expect { client.get('tags') }.to raise_error(NationBuilder::Error, /502: Bad Gateway/) { |e|
        expect(e.code).to be_nil
      }
    end
  end
end
