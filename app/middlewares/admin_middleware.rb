class AdminMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    if protected_route(request.path)
      unless is_token_invalid(request.params['token'])
        return [403, { 'Content-Type' => 'text/html', 'Content-Length' => 'Invalid token'.size.to_s }, ['Invalid admin token']]
      end
    end

    @app.call(env)
  end

  private

  def is_token_invalid(token)
    if token.to_s.length == 0
      return false
    end

    admin = User.find(1)
    admin.tokens == token
  end

  def protected_route(route)
    routes = %w(/sidekiq)
    routes.include? route
  end
end
