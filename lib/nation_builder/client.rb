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
    
    def get(path)
      self.token.get "https://#{hostname}/#{path}"
    end
  end
end