require 'oauth2'
require 'active_support/all'
require 'nation_builder/exceptions/validation_error'
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
    #  Initializes a new NationBuilder client
    #
    # @param [Hash] options the options to make the request with
    # @option options [String] :client_id client ID used for OAuth 2.0 authenticated requests
    # @option options [String] :client_secret secret used for OAuth 2.0 authenticated requests
    # @option options [String] :hostname NationBuilder site hostname, must not include protocol (i.e.: 'http://')
    # @option options [String] :token OAuth2 access token used for perform authenticated calls. Not required if performing authenticated calls with :username and :password
    # @option options [String] :username username used for getting a OAuth 2.0 access token. Not required if performing authenticated calls with :token
    # @option options [String] :password password used for getting a OAuth 2.0 access token. Not required if performing authenticated calls with :token
    # @option options [Proc] :instrumentation block of code to be invoked on every request to NationBuilder. Should receive a single Hash argument that includes :path and :request_type.
    #                                         :path argument is normalized, replacing IDs with '_'
    # @option options [Logger] :logger optional. If provided, rate limit related headers from successful responses will be logged.
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
