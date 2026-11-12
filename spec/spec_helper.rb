require 'nation_builder'
require 'webmock/rspec'
require 'json'

module NationBuilderHelpers
  # The client joins base_uri and paths with a double slash; NationBuilder accepts it
  BASE_URL = 'https://test.nationbuilder.com//api/v1'

  def nb_client
    NationBuilder.new(hostname: 'test.nationbuilder.com', token: 'secret-token')
  end

  # body may be a Hash, or a String of raw JSON such as a fixture
  def stub_nb(method, path, status: 200, body: {})
    body = JSON.generate(body) unless body.is_a?(String)
    stub_request(method, "#{BASE_URL}/#{path}")
      .to_return(status: status, body: body, headers: { 'Content-Type' => 'application/json' })
  end

  def fixture(name)
    File.read(File.expand_path("fixtures/#{name}.json", __dir__))
  end
end

RSpec.configure do |config|
  config.include NationBuilderHelpers
end
