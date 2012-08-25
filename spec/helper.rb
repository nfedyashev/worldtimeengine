require 'worldtimeengine'
require 'rspec'
require 'webmock/rspec'
require 'pry'

def a_get(path, endpoint='http://worldtimeengine.com')
  a_request(:get, endpoint + path)
end

def stub_get(path, endpoint='http://worldtimeengine.com')
  stub_request(:get, endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
