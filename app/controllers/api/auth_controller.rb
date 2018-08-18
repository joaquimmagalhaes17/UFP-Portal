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

    def register
      user = User.new(
          name: params[:name],
          email: params[:email],
          student_number: params[:student_number],
          password: params[:password].nil? ? '' : CipherHelper.encrypt(params[:password]),
          contact: params[:contact]
      )

      unless user.valid?
        return render json: user.errors.messages.to_json, status: 400
      end

      user.save
      render json: 'User created'.to_json, status: 201
    end
  end
end

