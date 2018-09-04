# frozen_string_literal: true

module Api::AtmHelper
  def self.parse(information)
    return [] if information == []

    data = []

    information.each do |entry|
      data << {
          entity: entry['Entidade'],
          reference: entry['Referencia'],
          total: entry['Total'],
          opening: entry['Inicio'],
          end: entry['Termo']
      }
    end

    data
  end
end
