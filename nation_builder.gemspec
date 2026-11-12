# frozen_string_literal: true

require_relative 'lib/nation_builder/version'

Gem::Specification.new do |spec|
  spec.name = 'nation_builder'
  spec.version = NationBuilder::VERSION
  spec.authors = ['Nathan Woodhull', 'Dan Schneiderman']
  spec.email = ['nathan@controlshiftlabs.com']

  spec.summary = 'NationBuilder API wrapper'
  spec.description = 'Ruby wrapper for the NationBuilder v1 people and tags API'
  spec.homepage = 'https://github.com/controlshift/nation_builder'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2'

  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb', 'CHANGELOG.md', 'LICENSE.txt', 'README.md']
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '>= 2.0', '< 3'
end
