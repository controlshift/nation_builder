module NationBuilder
  class Client
    attr_accessor :client, :token, :client_secret, :client_id, :username, :password, :hostname
    
    def initialize(args = {})
      args.each do |key, value|
        self.send("#{key}=".intern, value)
      end
      if username.present? && password.present?
        self.client = setup_client_from_password
      elsif token.present?
        self.client = setup_client_from_token
      end
    end
    
    def people
      NationBuilder::People.new(self)
    end
    
    def get(path, opts={})
      self.client.get "#{base_uri}#{path}", opts.merge(headers: headers)
    end
    
    def post(path, opts={})
      self.client.post "#{base_uri}#{path}", opts.merge(headers: headers)
    end

    def put(path, opts={})
      self.client.put "#{base_uri}#{path}", opts.merge(headers: headers)
    end
    
    private
    
    def setup_client_from_password
      setup_client.password.get_token(username, password)
    end

    def setup_client_from_token
      OAuth2::AccessToken.new(setup_client, token)
    end

    def setup_client
      OAuth2::Client.new(client_id, client_secret, :site => "https://#{hostname}", authorize_url: "https://#{hostname}/oauth/authorize", token_url: "https://#{hostname}/oauth/token" )
    end

    
    def headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      } 
    end
    
    def base_uri
      "https://#{hostname}/"
    end
  end
end
