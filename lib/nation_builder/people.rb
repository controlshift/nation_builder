module NationBuilder
  class People
    attr_accessor :client
    
    def initialize(client)
      self.client = client
    end
    
    def match(params)
      begin 
        JSON.parse(client.get('/api/v1/people/match', params: params).response.env[:body])
      rescue OAuth2::Error => e
        if e.code == 'no_matches'
          return nil
        else
          raise e
        end
      end
    end
    
    def list
      JSON.parse(client.get('/api/v1/people').response.env[:body])
    end
    
    def create params
      body = JSON.generate(params)
      JSON.parse(client.post('/api/v1/people', body: body).response.env[:body])
    end
  end  
end