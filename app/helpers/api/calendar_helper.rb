# frozen_string_literal: true

module Api
  module CalendarHelper
    def self.parse_exams(exams_data)
      exams = []

      exams_data.each do |entry|
        exams << {
          title: "#{entry['Disciplina']}\nSala: #{entry['Sala']}",
          start: entry['Data'],
          end: (DateTime.parse(entry['Data']) + 2.hours).strftime('%F %H:%M'),
          allDay: false,
          color: 'red',
          details: {
            curricular_unit: entry['Disciplina'],
            course: entry['Curso'],
            type: entry['Tipologia'],
            year: entry['AnoLectivo'],
            room: entry['Sala'],
            responsable: entry['Responsavel'].gsub!('<br>', ', ')
          }
        }
      end

      exams
    end

    def self.parse_schedule(data)
      schedule = []

      data.each do |entry|
        schedule << {
          title: "#{entry['Unidade']} (#{entry['Tipo']})\nSala: #{entry['Sala']}",
          start: "#{entry['Data']} #{entry['Inicio']}",
          end: "#{entry['Data']} #{entry['Termo']}",
          allDay: false,
          color: 'green',
          details: {
            opening: entry['Inicio'],
            end: entry['Termo'],
            type: entry['Tipo'],
            room: entry['Sala'],
            curricular_unit: entry['Unidade']
          }
        }
      end

      schedule
    end
  end
end
