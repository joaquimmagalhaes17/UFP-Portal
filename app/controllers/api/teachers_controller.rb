# frozen_string_literal: true

require 'nokogiri'

module Api
  class TeachersController < ApiController
    def all_teachers
      data = SOAPHandler.get_teachers
      render json: data
    end

    def teacher_information
      html = SOAPHandler.get_teacher(params[:initials])
      data = parse_teacher_data(html)
      render json: data
    end

    private

    def parse_teacher_data(html)
      puts html
      dom = Nokogiri::HTML(html)

      information = {
        name: dom.search('b').inner_text,
        last_update: '',
        email: '',
        schedule: []
      }

      items = dom.search('p')
      p_counter = 0

      ul_items = dom.search('ul')

      email = items.inner_text.to_s.scan(/[a-z0-9-]{1,30}@[a-z0-9-]{1,65}.[a-z]{1,}/)
      information[:email] = email[0] unless email.nil?

      items.each do |entry|
        if entry.inner_text == 'Ocupação Semanal do Docente'
          s_counter = p_counter + 1
          aux = 0

          while s_counter < items.count
            last_update = items[s_counter].inner_text.to_s.scan(/([\d]{4}-[\d]{2}-[\d]{2})/)

            if !last_update.nil? && last_update.count > 0
              information[:last_update] = (last_update[0].is_a? Array) ? last_update[0][0] : last_update[0]
            end

            if aux < ul_items.count
              days = ul_items[aux].inner_html.to_s.scan(/(?:<li>)(.*?)(?:<\/li>)/)
              puts items[s_counter].inner_text.delete!(':')

              information[:schedule] << {
                reason: items[s_counter].inner_text.delete!(':'),
                date: days[0][0]
              }
              aux += 1
            end

            s_counter += 1
          end
        end
        p_counter += 1
      end

      information
    end
  end
end
