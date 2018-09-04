class Api::ScheduleController < ApplicationController
  def get_schedule
    token = JSON.parse(CipherHelper.decrypt(params[:token]))
    information = SOAPHandler.get_schedule(token['token'])

    # TODO Wait until have information to process data
    render json: {
        status: 'Ok',
        message: information
    }.to_json, status: 200
  end
end
