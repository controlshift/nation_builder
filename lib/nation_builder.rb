# frozen_string_literal: true

require 'faraday'
require 'nation_builder/version'
require 'nation_builder/errors'
require 'nation_builder/client'
require 'nation_builder/resource'
require 'nation_builder/people'
require 'nation_builder/tags'

module NationBuilder
  # Shorthand for NationBuilder::Client.new
  def self.new(...)
    Client.new(...)
  end
end
