module Api
  class MenuController < ApiController
    def get_menu
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      information = SOAPHandler.get_menu(token['token'])

      render json: {
        status: 'Ok',
        message: information
      }.to_json, status: 200
    end
  end
end
