# frozen_string_literal: true

class APIMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    if protected_route(request.path)
      if request.params['token'].to_s.empty?
        return [403, { 'Content-Type' => 'text/html', 'Content-Length' => 'Invalid token'.size.to_s }, ['Invalid token']]
      end
    end

    @app.call(env)
  end

  private

  def protected_route(route)
    routes = [
      '/api/grades/provisional/partial',
      '/api/grades/provisional/final',
      ' /api/grades/definitive/recent',
      '/api/grades/definitive/historic',
      '/api/assiduity'
    ]

    routes.include? route
  end
end
