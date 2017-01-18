require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NationBuilder::Client do
  shared_examples 'request' do
    let(:client) { double }

    subject { NationBuilder::Client.new(hostname: 'nationbuilder.com') }

    before :each do
      expect(subject).to receive(:client).and_return(client)
    end

    context 'request path does not include ID' do
      let(:request_path) { 'foo/bar' }

      before :each do
        expect(client).to receive(request_type).with('https://nationbuilder.com/foo/bar', hash_including(headers: subject.send(:headers)))
      end

      it 'should perform instrumented request if instrumentation set' do
        instrumentation = double
        expect(instrumentation).to receive(:call).with(hash_including(path: request_path, request_type: request_type))
        expect(subject).to receive(:instrumentation).at_least(:once).and_return(instrumentation)

        subject.send(request_type, request_path)
      end

      it 'should perform uninstrumented request if instrumentation not set' do
        expect(subject).to receive(:instrumentation).and_return(nil)

        subject.send(request_type, request_path)
      end
    end

    context 'request path includes ID' do
      let(:request_path) { 'foo/123/bar' }

      before :each do
        expect(client).to receive(request_type).with('https://nationbuilder.com/foo/123/bar', hash_including(headers: subject.send(:headers)))
      end

      it 'should perform instrumented request normalizing path' do
        instrumentation = double
        expect(instrumentation).to receive(:call).with(hash_including(path: 'foo/_/bar', request_type: request_type))
        expect(subject).to receive(:instrumentation).at_least(:once).and_return(instrumentation)

        subject.send(request_type, request_path)
      end
    end

    describe 'error handling' do
      let(:error_response) { double(parsed: nil, body: 'This is an error') }
      let(:oauth_exception) { OAuth2::Error.new(error_response) }

      before :each do
        allow(error_response).to receive(:error=)
        expect(client).to receive(request_type).and_raise(oauth_exception)
      end

      context 'error code is "rate_limited"' do
        before :each do
          expect(oauth_exception).to receive(:code).and_return('rate_limited')
        end

        it 'should raise RateLimitedError' do
          limit_reset = Time.parse('2017-01-01 12:00 +0000')
          allow(error_response).to receive(:headers).and_return({'x-ratelimit-limit' => '100', 'x-ratelimit-remaining' => '0', 'x-ratelimit-reset' => limit_reset.to_i})

          error_message = "NationBuilder rate limit error. Current values:\nLimit: 100\nRemaining: 0\nReset: #{Time.at(limit_reset.to_i)}\nBody: This is an error"

          expect { subject.send(request_type, 'foo/bar') }.to raise_error NationBuilder::RateLimitedError, error_message
        end

        it 'should not fail if "x-ratelimit-reset" header not present' do
          allow(error_response).to receive(:headers).and_return({'x-ratelimit-limit' => '100', 'x-ratelimit-remaining' => '0'})
          error_message = "NationBuilder rate limit error. Current values:\nLimit: 100\nRemaining: 0\nReset: #{Time.at(0)}\nBody: This is an error"

          expect { subject.send(request_type, 'foo/bar') }.to raise_error NationBuilder::RateLimitedError, error_message
        end
      end

      it 'should raise generic exception if code is not "rate_limited"' do
        expect(oauth_exception).to receive(:code).and_return('another_error')

        expect { subject.send(request_type, 'foo/bar') }.to raise_error oauth_exception
      end
    end
  end

  [:get, :post, :put, :delete].each do |request|
    describe "##{request}" do
      it_behaves_like 'request' do
        let(:request_type) { request }
      end
    end
  end
end
