# frozen_string_literal: true

module Api
  class CalendarController < ApiController
    def index
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      exams_data = SOAPHandler.exams(token['token'])
      schedule_data = SOAPHandler.get_schedule(token['token'])

      exams = CalendarHelper.parse_exams(exams_data)
      schedule = CalendarHelper.parse_schedule(schedule_data)

      render json: exams.concat(schedule), status: 200
    end
  end
end
