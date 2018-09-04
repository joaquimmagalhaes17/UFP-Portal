module Api
  class ExamsController < ApiController
    def get_exams
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      information = SOAPHandler.exams(token['token'])

      render json: {
        status: 'Ok',
        message: ExamsHelper.parse(information)
      }.to_json, status: 200
    end
  end
end
