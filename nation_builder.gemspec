require_relative 'lib/nation_builder/version'

Gem::Specification.new do |spec|
  spec.name = 'nation_builder'
  spec.version = NationBuilder::VERSION
  spec.authors = ['Nathan Woodhull', 'Dan Schneiderman']
  spec.email = ['nathan@controlshiftlabs.com']

  spec.summary = 'NationBuilder API wrapper'
  spec.description = 'Ruby wrapper for NationBuilder API'
  spec.homepage = 'https://github.com/controlshift/nation_builder'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.3'

  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb', 'LICENSE.txt', 'README.md']
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 7.0'
  spec.add_dependency 'json', '>= 2.1'
  spec.add_dependency 'oauth2', '~> 2.0'
end
