require 'oauth2'
require 'nation_builder/client'
require 'nation_builder/people'

module NationBuilder 

  class << self
    def new(options = {})
      NationBuilder::Client.new(options)
    end
    
    def method_missing(method, *args) 
      return super unless new.respond_to?(method)
      new.send(method, *args)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end