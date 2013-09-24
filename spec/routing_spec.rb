require 'spec_helper'

describe MyWay::Base do

  before do 
    @app = MyWay::Base.new
    Capybara.app = @app
  end

  describe "GET" do
    before do 
      @app.get '/' do 
        "Hello World"
      end

      @app.get '/(\d+)/(\d+)' do |env, num1, num2|
        "Numbers #{num1},#{num2}"
      end
    end

    it "should work" do 
      page.visit '/'
      page.should have_content('Hello World')
      page.visit '/12/13'
      page.should have_content("Numbers 12,13")
    end

  end

end
