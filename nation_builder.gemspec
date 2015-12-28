# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: nation_builder 0.0.6 ruby lib

Gem::Specification.new do |s|
  s.name = "nation_builder"
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nathan Woodhull", "Dan Schneiderman"]
  s.date = "2015-12-28"
  s.description = "Ruby wrapper for NationBuilder API"
  s.email = "nathan@controlshiftlabs.com"
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
    "Gemfile.lock",
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
  s.homepage = "http://github.com/controlshift/nation_builder"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "NationBuilder API wrapper"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth2>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, ["> 3.0.0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<pry-byebug>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.7"])
    else
      s.add_dependency(%q<oauth2>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<activesupport>, ["> 3.0.0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<pry-byebug>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
    end
  else
    s.add_dependency(%q<oauth2>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<activesupport>, ["> 3.0.0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<pry-byebug>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
  end
end

