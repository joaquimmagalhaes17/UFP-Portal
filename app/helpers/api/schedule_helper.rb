# frozen_string_literal: true

module Api::ScheduleHelper
  def self.parse(data)
    schedule = []

    data.each do |entry|
      day_entry = get_day_object(schedule, entry['Data'])

      day_entry[:classes] << {
        opening: entry['Inicio'],
        end: entry['Termo'],
        type: entry['Tipo'],
        room: entry['Sala'],
        curricular_unit: entry['Unidade']
      }
    end

    schedule
  end

  def self.get_day_object(schedule, day)
    schedule.each do |entry|
      return entry if entry[:day] == day
    end

    entry = {
      day: day,
      classes: []
    }

    schedule << entry
    entry
  end
end
