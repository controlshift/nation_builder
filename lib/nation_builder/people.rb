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
        if e.response.parsed['code'] == 'no_matches'
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

    def update id, params
      body = JSON.generate(params)
      JSON.parse(client.put("/api/v1/people/#{id}", body: body).response.env[:body])
    end

    def create_or_update params
      person = self.match('email' => params['person']['email'])
      if(person)
        new_person = person['person'].merge(params['person'])
        self.update new_person['id'], 'person' => new_person
      else
        self.create params
      end
    end
  end  
end
