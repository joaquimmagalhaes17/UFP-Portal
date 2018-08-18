# frozen_string_literal: true

module Api
  class GradesController < ApiController
    def provisional_partial
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      partial_grades = SOAPHandler.provisional_partial_grades(token['token'])

      if !params[:table_format].nil? && params[:table_format]
        return render json: GradesHelper.parse_partial_to_table(partial_grades, params), status: 200
      end

      response = {
        status: 'Ok',
        message: GradesHelper.parse_partial_grades(partial_grades)
      }

      render json: response, status: 200
    end

    def provisional_partial_years
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      partial_grades = SOAPHandler.provisional_partial_grades(token['token'])

      response = {
        status: 'Ok',
        message: GradesHelper.parse_partial_years(partial_grades)
      }

      render json: response, status: 200
    end

    def provisional_final
      token = JSON.parse(CipherHelper.decrypt(params[:token]))

      grades = GradesHelper.parse_final_grades(SOAPHandler.provisional_final_grades(token['token']))

      if !params[:table_format].nil? && params[:table_format]
        return render json: GradesHelper.parse_without_pagination(grades), status: 200
      end

      response = {
        status: 'Ok',
        message: grades
      }

      render json: response.to_json, status: 200
    end

    def definitive_recent
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      web_token = ScrapperHelper.login(token['username'], token['password'])

      grades = ScrapperHelper.definitive_recent_grades(web_token)

      if !params[:table_format].nil? && params[:table_format]
        return render json: GradesHelper.parse_without_pagination(grades), status: 200
      end

      response = {
        status: 'Ok',
        message: grades
      }

      render json: response, status: 200
    end

    def definitive_historic
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      historic_grades = SOAPHandler.definitive_historic_grades(token['token'])

      if !params[:table_format].nil? && params[:table_format]
        return render json: GradesHelper.parse_historic_to_table(historic_grades, params), status: 200
      end

      response = {
        status: 'Ok',
        message: GradesHelper.parse_historic_grades(historic_grades)
      }

      render json: response, status: 200
    end
  end
end
