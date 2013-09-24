require 'capybara'
require 'my_way'

Rspec::configure do |config|
  config.include Capybara::DSL
end

