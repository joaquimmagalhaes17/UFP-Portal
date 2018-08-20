# frozen_string_literal: true

module Api
  class AuthController < ApiController
    def login
      response = SOAPHandler.login(params[:username], params[:password])

      unless response
        return render json: {
          status: 'Error',
          message: 'Invalid credentials'
        }.to_json, status: 401
      end

      token = {
        username: params[:username],
        password: params[:password],
        token: response
      }

      render json: {
        status: 'Ok',
        message: CipherHelper.encrypt(JSON.dump(token))
      }.to_json, status: 200
    end
  end
end
