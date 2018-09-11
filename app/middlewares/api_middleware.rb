# frozen_string_literal: true

class APIMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    if request.path != '/api/login' && protected_route(request.path)
      if request.params['token'].to_s.empty?
        return [
          403,
          { 'Content-Type' => 'text/html', 'Content-Length' => 'Invalid token'.size.to_s },
          ['Invalid token']
        ]
      end
    end

    @app.call(env)
  end

  private

  def verify_token(token)
    CipherHelper.decrypt(token)
  end

  def protected_route(route)
    route.to_s.match('(?<=\/api).*$')
  end
end
