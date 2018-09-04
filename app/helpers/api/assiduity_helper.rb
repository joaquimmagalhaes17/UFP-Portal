# frozen_string_literal: true

module Api::AssiduityHelper
  def self.parse(all_assiduity)
    data = []
    units_inserted = []

    all_assiduity.each do |entry|
      unless units_inserted.include? entry['Unidade']
        data << {
          curricular_unit: entry['Unidade'],
          information: []
        }

        units_inserted << entry['Unidade']
      end

      data.each do |unit|
        next unless unit[:curricular_unit] == entry['Unidade']
        unit[:information] << {
          year: entry['AnoLectivo'],
          type: entry['Tipo'],
          class_name: entry['Turma'],
          assiduity: entry['Assiduidade']
        }
        break
      end
    end
    data
  end

  def self.to_table(all_assiduity)
    data = []
    all_assiduity.each do |entry|
      data << {
        curricular_unit: entry['Unidade'],
        year: entry['AnoLectivo'],
        type: entry['Tipo'],
        class: entry['Turma'],
        assiduity: entry['Assiduidade']
      }
    end

    {
      total: data.count,
      per_page: data.count,
      current_page: 0,
      last_page: 0,
      next_page_url: false,
      prev_page_url: false,
      from: 0,
      to: data.count,
      data: data
    }
  end
end
