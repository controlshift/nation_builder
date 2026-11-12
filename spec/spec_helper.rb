require 'nation_builder'
require 'webmock/rspec'
require 'json'

module NationBuilderHelpers
  # The client joins base_uri and paths with a double slash; NationBuilder accepts it
  BASE_URL = 'https://test.nationbuilder.com//api/v1'

  def nb_client
    NationBuilder.new(hostname: 'test.nationbuilder.com', token: 'secret-token')
  end

  def stub_nb(method, path, status: 200, body: {})
    stub_request(method, "#{BASE_URL}/#{path}")
      .to_return(status: status, body: JSON.generate(body), headers: { 'Content-Type' => 'application/json' })
  end
end

RSpec.configure do |config|
  config.include NationBuilderHelpers
end
