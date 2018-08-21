# frozen_string_literal: true

module Api
  class CalendarController < ApiController
    def index
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      exams_data = SOAPHandler.exams(token['token'])

      data = CalendarHelper.parse_exams(exams_data)

      render json: data, status: 200
    end
  end
end
