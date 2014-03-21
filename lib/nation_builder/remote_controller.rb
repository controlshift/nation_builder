module NationBuilder
  class RemoteController
    attr_accessor :client

    def initialize(client)
      self.client = client
    end

    def base_uri
      '/api/v1/'
    end

    def controller_name
      raise 'implement me'
    end

    def base_path
      base_uri + controller_name
    end

  end
end