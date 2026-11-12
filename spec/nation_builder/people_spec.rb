# frozen_string_literal: true

RSpec.describe NationBuilder::People do
  subject(:people) { nb_client.people }

  let(:person) { { 'person' => { 'id' => 17, 'email' => 'george@example.com' } } }

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

    it 're-raises other errors' do
      stub_request(:get, "#{NationBuilderHelpers::BASE_URL}/people/match?email=x@example.com")
        .to_return(status: 500, body: '{"code":"server_error"}', headers: { 'Content-Type' => 'application/json' })

      expect { people.match('email' => 'x@example.com') }.to raise_error(NationBuilder::Error)
    end
  end

  it '#list returns the people page' do
    stub_nb(:get, 'people', body: { 'results' => [] })

    expect(people.list).to eq('results' => [])
  end

  it '#show fetches a person' do
    stub_nb(:get, 'people/17', body: person)

    expect(people.show(17)).to eq(person)
  end

  it '#create posts the person' do
    stub_nb(:post, 'people', status: 201, body: person).with(body: person)

    expect(people.create(person)).to eq(person)
  end

  it '#update puts the person' do
    stub_nb(:put, 'people/17', body: person).with(body: { 'person' => { 'email_opt_in' => false } })

    expect(people.update(17, 'person' => { 'email_opt_in' => false })).to eq(person)
  end

  it '#add puts to people/add' do
    stub_nb(:put, 'people/add', body: person).with(body: person)

    expect(people.add(person)).to eq(person)
  end

  it '#push puts to people/push' do
    stub_nb(:put, 'people/push', body: person).with(body: person)

    expect(people.push(person)).to eq(person)
  end

  it '#search passes params as a query string' do
    stub_request(:get, "#{NationBuilderHelpers::BASE_URL}/people/search?last_name=Washington")
      .to_return(status: 200, body: '{"results":[]}', headers: { 'Content-Type' => 'application/json' })

    expect(people.search('last_name' => 'Washington')).to eq('results' => [])
  end

  describe 'taggings' do
    it '#taggings lists them' do
      stub_nb(:get, 'people/17/taggings', body: { 'taggings' => [] })

      expect(people.taggings(17)).to eq('taggings' => [])
    end

    it '#add_tagging puts the tag' do
      stub_nb(:put, 'people/17/taggings', body: { 'tagging' => { 'tag' => 'volunteer' } })
        .with(body: { 'tagging' => { 'tag' => 'volunteer' } })

      expect(people.add_tagging(17, 'volunteer')).to eq('tagging' => { 'tag' => 'volunteer' })
    end

    it '#delete_tagging escapes the tag as a path segment' do
      stub = stub_request(:delete, "#{NationBuilderHelpers::BASE_URL}/people/17/taggings/big%20donor")
             .to_return(status: 204)

      people.delete_tagging(17, 'big donor')

      expect(stub).to have_been_requested
    end
  end
end
