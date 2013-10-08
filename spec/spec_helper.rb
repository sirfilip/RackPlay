require 'rack/test'
require 'capybara'
require 'my_way'

RSpec::configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
end

