$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'nation_builder'
require 'webmock/rspec'
require 'json'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}


RSpec.configure do |config|
  config.include WebMock::API

  config.before(:each) do
    WebMock.reset!
    WebMock.allow_net_connect!
  end
  config.after(:each) do
    WebMock.reset!
  end
end


# Allow real connections

def stub_get(path)
  stub_nation_builder_request(:get, path)
end

def stub_post(path)
  stub_nation_builder_request(:post, path)
end

def stub_nation_builder_request(method, path)
  stub_request(method, "https://test.com" + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(File.join(fixture_path, '/', file))
end
