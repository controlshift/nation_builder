module NationBuilder
  class Client
    attr_accessor :token, :client_secret, :client_id, :username, :password, :hostname
    
    def initialize(args = {})
      args.each do |key, value|
        self.send("#{key}=".intern, value)
      end
      client = OAuth2::Client.new(client_id, client_secret, :site => "https://#{hostname}", authorize_url: "https://#{hostname}/oauth/authorize", token_url: "https://#{hostname}/oauth/token" )
      self.token = client.password.get_token(username, password)
    end
    
    
    def people
      NationBuilder::People.new(self)
    end
    
    def get(path, opts={})
      self.token.get "#{base_uri}#{path}", opts.merge(headers: headers)
    end
    
    def post(path, opts={})
      self.token.post "#{base_uri}#{path}", opts.merge(headers: headers)
    end
    
    private
    
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