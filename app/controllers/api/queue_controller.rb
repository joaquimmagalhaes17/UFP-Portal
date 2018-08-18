# frozen_string_literal: true

module Api
  class QueueController < ApiController
    def get_queue
      response = RestClient.post('http://senha.ufp.pt/Home/getFilaMin', {})

      unless response.code == 200
        render json: 'Internal error', response_code: 500
      end

      all_tickets = JSON.parse(response.body)
      tickets = []

      all_tickets.each do |ticket|
        tickets << {
          service_code: ticket['SERVICE_CODE'],
          information: {
            desc: ticket['SERVICO'],
            last_update: ticket['START_HOUR'],
            number: ticket['TICK_NUMBER'],
            waiting: ticket['WAIT']
          }
        }
      end

      render json: tickets.to_json, response_code: 200
    end
  end
end
