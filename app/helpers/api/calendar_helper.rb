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
            responsable: entry['Responsavel']
          }
        }
      end

      exams
    end
  end
end
