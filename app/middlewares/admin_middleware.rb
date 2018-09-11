# frozen_string_literal: true

require 'json'

class AdminMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    if protected_route(request.path)
      unless is_token_invalid(request.params['token'])
        return [403, { 'Content-Type' => 'text/html', 'Content-Length' => 'Forbidden'.size.to_s }, ['Forbidden']]
      end
    end

    @app.call(env)
  end

  private

  def get_user_from_token(token)
    data = JSON.parse(CipherHelper.decrypt(token))
    data['username']
  end

  def is_token_invalid(token)
    return false if token.to_s.empty?
    number = get_user_from_token(token)

    begin
      user = User.find_by(student_number: number)
      return user.admin unless user.nil?
    rescue ActiveRecord::RecordNotFound
      return false
    end
  end

  def protected_route(route)
    route.to_s.match('(?<=\/api\/admin\/).*$')
  end
end
