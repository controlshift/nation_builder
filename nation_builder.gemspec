# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: nation_builder 0.0.16 ruby lib

Gem::Specification.new do |s|
  s.name = "nation_builder".freeze
  s.version = "0.0.16"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nathan Woodhull".freeze, "Dan Schneiderman".freeze]
  s.date = "2018-12-04"
  s.description = "Ruby wrapper for NationBuilder API".freeze
  s.email = "nathan@controlshiftlabs.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".ruby-gemset",
    ".ruby-version",
    ".travis.yml",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/nation_builder.rb",
    "lib/nation_builder/actions/create.rb",
    "lib/nation_builder/actions/list.rb",
    "lib/nation_builder/actions/show.rb",
    "lib/nation_builder/actions/update.rb",
    "lib/nation_builder/client.rb",
    "lib/nation_builder/exceptions/validation_error.rb",
    "lib/nation_builder/people.rb",
    "lib/nation_builder/remote_controller.rb",
    "lib/nation_builder/tags.rb",
    "nation_builder.gemspec",
    "spec/client_spec.rb",
    "spec/fixtures/not_found",
    "spec/fixtures/people_list_empty",
    "spec/fixtures/people_list_success",
    "spec/nation_builder_spec.rb",
    "spec/people_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/controlshift/nation_builder".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "NationBuilder API wrapper".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth2>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<json>.freeze, ["~> 2.1"])
      s.add_runtime_dependency(%q<activesupport>.freeze, ["> 3.0.0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 3.0.1", "~> 3.0"])
      s.add_development_dependency(%q<byebug>.freeze, [">= 9.0.6", "~> 9.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.6"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<juwelier>.freeze, [">= 2.4.7", "~> 2.4"])
    else
      s.add_dependency(%q<oauth2>.freeze, [">= 0"])
      s.add_dependency(%q<json>.freeze, ["~> 2.1"])
      s.add_dependency(%q<activesupport>.freeze, ["> 3.0.0"])
      s.add_dependency(%q<webmock>.freeze, [">= 3.0.1", "~> 3.0"])
      s.add_dependency(%q<byebug>.freeze, [">= 9.0.6", "~> 9.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.6"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<juwelier>.freeze, [">= 2.4.7", "~> 2.4"])
    end
  else
    s.add_dependency(%q<oauth2>.freeze, [">= 0"])
    s.add_dependency(%q<json>.freeze, ["~> 2.1"])
    s.add_dependency(%q<activesupport>.freeze, ["> 3.0.0"])
    s.add_dependency(%q<webmock>.freeze, [">= 3.0.1", "~> 3.0"])
    s.add_dependency(%q<byebug>.freeze, [">= 9.0.6", "~> 9.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.6"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<juwelier>.freeze, [">= 2.4.7", "~> 2.4"])
  end
end

