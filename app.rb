class RouteNotFound < StandardError; end

class App

  def initialize
    @routes = {}  
  end

  def get(path, &block)
    @routes["GET #{path}"] = block
  end


  def post(path, &block)
    @routes["POST #{path}"] = block
  end

  def put(path, &block)
    @routes["POST #{path}"] = block
  end

  def delete(path, &block)
    @routes["POST #{path}"] = block
  end

  def call(env)
    block, *params = detect_route env
    response = block.call(params)
    [200, {"Content-Type" => "text/plain"}, [response]]
  rescue RouteNotFound
    show_404
  end

private 
  def detect_route env
    @routes.each do |match, block|
      method, regex = match.split(' ')
      regex << '/?'
      if method == env['REQUEST_METHOD'] && /^#{regex}$/.match(env['PATH_INFO'])
        return block, Regexp.last_match.captures 
      end
    end
    raise RouteNotFound.new
  end

  def show_404
    [404, {"Content-Type" => "text/plain"}, ["Page not found"]]
  end
  
end
