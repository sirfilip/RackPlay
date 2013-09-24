require 'rack'
require './app.rb'

app = App.new

app.get '/' do 
  "Hello World"  
end

app.get '/(\d+)' do |env, id|
  "Hello #{id}"
end

app.get '/(\d+)/(\d+)' do |env, one, two|
  "Numbers are #{one} and #{two}"
end

Rack::Handler::WEBrick.run app
