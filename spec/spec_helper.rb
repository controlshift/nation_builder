# frozen_string_literal: true

require 'nation_builder'
require 'webmock/rspec'
require 'json'

module NationBuilderHelpers
  BASE_URL = 'https://test.nationbuilder.com/api/v1'

  def nb_client(**)
    NationBuilder::Client.new(hostname: 'test.nationbuilder.com', token: 'secret-token', **)
  end

  def stub_nb(method, path, status: 200, body: nil, headers: {})
    stub_request(method, "#{BASE_URL}/#{path}")
      .to_return(status:, body: body && JSON.generate(body),
                 headers: { 'Content-Type' => 'application/json; charset=utf-8' }.merge(headers))
  end
end

RSpec.configure do |config|
  config.include NationBuilderHelpers
  config.disable_monkey_patching!
  config.order = :random
end
