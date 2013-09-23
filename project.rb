require 'rack'
require './app.rb'

app = App.new

app.get '/' do 
  "Hello World"  
end

app.get '/(\d+)' do |id|
  "Hello #{id}"
end

Rack::Handler::WEBrick.run app
