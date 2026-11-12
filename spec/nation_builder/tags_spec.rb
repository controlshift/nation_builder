# frozen_string_literal: true

RSpec.describe NationBuilder::Tags do
  subject(:tags) { nb_client.tags }

  it '#list returns the tags page' do
    stub_nb(:get, 'tags', body: { 'results' => [{ 'name' => 'volunteer' }] })

    expect(tags.list).to eq('results' => [{ 'name' => 'volunteer' }])
  end

  it '#people lists people with the tag' do
    stub_request(:get, "#{NationBuilderHelpers::BASE_URL}/tags/big%20donor/people")
      .to_return(status: 200, body: '{"results":[]}', headers: { 'Content-Type' => 'application/json' })

    expect(tags.people('big donor')).to eq('results' => [])
  end
end
