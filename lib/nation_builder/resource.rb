# frozen_string_literal: true

module NationBuilder
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def list = client.get(base_path).body

    private

    def base_path = raise(NotImplementedError)

    def member_path(id) = "#{base_path}/#{URI.encode_uri_component(id.to_s)}"
  end
end
