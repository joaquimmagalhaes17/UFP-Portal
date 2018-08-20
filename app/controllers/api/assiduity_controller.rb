# frozen_string_literal: true

module Api
  class AssiduityController < ApiController
    def get_assiduity
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      all_assiduity = SOAPHandler.get_assiduity(token['token'])

      if !params[:table_format].nil? && params[:table_format]
        data = AssiduityHelper.to_table(all_assiduity)
        return render json: data.to_json, response_code: 200
      end

      response = {
        status: 'Ok',
        message: AssiduityHelper.parse(all_assiduity)
      }
      render json: response, response_code: 200
    end
  end
end
