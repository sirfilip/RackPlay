require 'spec_helper'

describe MyWay::Base do

  before do 
    @app = MyWay::Base.new
    Capybara.app = @app
  end

  def app
    @app
  end

  describe "GET" do
    before do 
      @app.get '/' do 
        [200, {'Content-type' => 'text/plain'}, ["Hello World"]]
      end

      @app.get '/(\d+)/(\d+)' do |env, num1, num2|
        [200, {'Content-type' =>'text/plain'}, ["Numbers #{num1},#{num2}"]]
      end
    end

    it "should work" do 
      page.visit '/'
      page.should have_content('Hello World')
      page.visit '/12/13'
      page.should have_content("Numbers 12,13")
    end

    it "should not match a post route" do
      post '/'
      last_response.status.should == 404
    end

  end

end
