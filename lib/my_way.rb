module MyWay

  class RouteNotFound < StandardError; end

  class Base

    def initialize
      @routes = {}
      ['get', 'post', 'put', 'delete'].each {|m| @routes[m] = {}}
    end

    def get(path, &block)
      @routes['get'][path] = block
    end


    def post(path, &block)
      @routes['post'][path] = block
    end

    def put(path, &block)
      @routes['put'][path] = block
    end

    def delete(path, &block)
      @routes['delete'][path] = block
    end

    def call(env)
      block, params = detect_route env
      block.call(env, *params)
    rescue RouteNotFound
      show_404
    end

  private 
    def detect_route env
      @routes[env['REQUEST_METHOD'].downcase].each do |path, block|
        if /^#{path.chomp('/')}\/?$/.match(env['PATH_INFO'])
          return block, Regexp.last_match.captures 
        end
      end
      raise RouteNotFound.new
    end

    def show_404
      [404, {"Content-Type" => "text/plain"}, ["Page not found"]]
    end
    
  end

end
