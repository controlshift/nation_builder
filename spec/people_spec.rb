require 'spec_helper'

describe NationBuilder::People do
  subject(:people) { nb_client.people }

  let(:person) { { 'person' => { 'id' => 17, 'email' => 'george@example.com' } } }

  it 'sends the token as a bearer header' do
    stub = stub_nb(:get, 'people', body: { 'results' => [] })
           .with(headers: { 'Authorization' => 'Bearer secret-token' })

    people.list

    expect(stub).to have_been_requested
  end

  describe '#list' do
    it 'returns an empty result set if the nation is empty' do
      stub_nb(:get, 'people', body: fixture('people_list_empty'))

      expect(people.list['results']).to be_empty
    end

    it 'returns the people in the nation' do
      stub_nb(:get, 'people', body: fixture('people_list_success'))

      list = people.list

      expect(list['total']).to eq(4)
      expect(list['results'].map { |p| p['email'] }).to include('johndoe@gmail.com')
    end
  end

  describe '#match' do
    it 'returns the matching person' do
      stub_request(:get, "#{NationBuilderHelpers::BASE_URL}/people/match?email=george@example.com")
        .to_return(status: 200, body: JSON.generate(person), headers: { 'Content-Type' => 'application/json' })

      expect(people.match('email' => 'george@example.com')).to eq(person)
    end

    it 'returns nil when there is no match' do
      stub_request(:get, "#{NationBuilderHelpers::BASE_URL}/people/match?email=nobody@example.com")
        .to_return(status: 400, body: '{"code":"no_matches","message":"No people matched the given criteria."}',
                   headers: { 'Content-Type' => 'application/json' })

      expect(people.match('email' => 'nobody@example.com')).to be_nil
    end

    it 'raises OAuth2::Error for other failures' do
      stub_request(:get, "#{NationBuilderHelpers::BASE_URL}/people/match?email=x@example.com")
        .to_return(status: 500, body: '{"code":"server_error"}', headers: { 'Content-Type' => 'application/json' })

      expect { people.match('email' => 'x@example.com') }.to raise_error(OAuth2::Error)
    end
  end

  describe '#add' do
    it 'puts the person to people/add' do
      stub_nb(:put, 'people/add', body: person).with(body: person)

      expect(people.add(person)).to eq(person)
    end

    it 'raises ValidationError when validation fails' do
      stub_nb(:put, 'people/add', status: 400,
                                  body: { 'code' => 'validation_failed', 'message' => 'Validation Failed.',
                                          'validation_errors' => ['email is invalid'] })

      expect { people.add(person) }.to raise_error(NationBuilder::Exceptions::ValidationError) { |e|
        expect(e.errors).to eq(['email is invalid'])
      }
    end
  end

  describe '#update' do
    it 'puts the person' do
      stub_nb(:put, 'people/17', body: person).with(body: { 'person' => { 'email_opt_in' => false } })

      expect(people.update(17, 'person' => { 'email_opt_in' => false })).to eq(person)
    end

    it 'raises OAuth2::Error with a 404 response when the person does not exist' do
      stub_nb(:put, 'people/99', status: 404, body: fixture('not_found'))

      expect { people.update(99, 'person' => { 'email_opt_in' => false }) }.to raise_error(OAuth2::Error) { |e|
        expect(e.response.status).to eq(404)
        expect(e.response.parsed['code']).to eq('not_found')
      }
    end
  end

  it '#add_tagging puts the tag' do
    stub_nb(:put, 'people/17/taggings', body: { 'tagging' => { 'tag' => 'volunteer' } })
      .with(body: { 'tagging' => { 'tag' => 'volunteer' } })

    expect(people.add_tagging(17, 'volunteer')).to eq('tagging' => { 'tag' => 'volunteer' })
  end
end
