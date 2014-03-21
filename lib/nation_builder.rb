require 'oauth2'
require 'active_support/all'
require 'nation_builder/actions/show'
require 'nation_builder/actions/list'
require 'nation_builder/actions/update'
require 'nation_builder/actions/create'
require 'nation_builder/client'
require 'nation_builder/remote_controller'
require 'nation_builder/tags'
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