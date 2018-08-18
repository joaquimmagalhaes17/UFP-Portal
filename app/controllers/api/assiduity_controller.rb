module Api
  class AssiduityController < ApiController
    def get_assiduity
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      all_assiduity = SOAPHandler.get_assiduity(token['token'])

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
              class: entry['Turma'],
              assiduity: entry['Assiduidade']
          }
          break
        end
      end

      render json: data.to_json, response_code: 200
    end
  end
end

