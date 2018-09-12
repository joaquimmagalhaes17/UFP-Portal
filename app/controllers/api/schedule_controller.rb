# frozen_string_literal: true

module Api
  class ScheduleController < ApiController
    def get_schedule
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      information = SOAPHandler.get_schedule(token['token'])

      render json: {
        status: 'Ok',
        message: ScheduleHelper.parse(information)
      }.to_json, status: 200
    end
  end
end
