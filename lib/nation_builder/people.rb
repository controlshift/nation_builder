module NationBuilder
  class People < RemoteController
    include NationBuilder::Actions::List
    include NationBuilder::Actions::Update
    include NationBuilder::Actions::Create

    def controller_name
      'people'
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
