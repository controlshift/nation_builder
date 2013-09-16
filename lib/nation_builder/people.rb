module NationBuilder
  class People
    attr_accessor :client
    
    def initialize(client)
      self.client = client
    end
    
    def list()
      JSON.parse(client.get('/api/v1/people').response.env[:body])
    end
  end  
end