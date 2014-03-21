module NationBuilder
  class People < RemoteController
    include NationBuilder::Actions::Show
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

    def taggings(person_id)
      JSON.parse(client.get(taggings_path(person_id)).response.env[:body])
    end

    def add_tagging(person_id, tag)
      body = JSON.generate({'tagging' => {'tag' => tag}})
      JSON.parse(client.put(taggings_path(person_id), body: body).response.env[:body])
    end

    def delete_tagging(person_id, tag)
      response = client.delete("#{taggings_path(person_id)}/#{tag}")
      if response.response.env[:status] == 204
        return true
      else
        return response
      end
    end

    private

    def taggings_path(person_id)
      "#{base_path}/#{person_id}/taggings"
    end
  end  
end
