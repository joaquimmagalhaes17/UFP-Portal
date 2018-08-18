module Api
  class AtmController < ApiController
    def get_atm
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      information = SOAPHandler.get_atm(token['token'])

      render json: {
          status: 'Ok',
          message: information
      }.to_json, status: 200
    end
  end
end

