# frozen_string_literal: true

require 'rubygems'
require 'savon'
require 'json'

module SOAPHandler
  @client = Savon.client(wsdl: 'https://portal.ufp.pt/hi5.asmx?WSDL')

  def initialize
    @client = Savon.client(wsdl: 'https://portal.ufp.pt/hi5.asmx?WSDL')
  end

  def self.login(number, password)
    response = @client.call(:encrypt, message: { phrase: "#{number},#{password}" })
    key = response.body[:encrypt_response][:encrypt_result]

    return false if key.to_s.empty? || key.nil?

    response = @client.call(:shake_hands, message: { input: key.to_s })
    response.body[:shake_hands_response][:shake_hands_result]
  end

  def self.provisional_partial_grades(token)
    response = @client.call(:grade, message: { token: token })
    grades_string = response.body[:grade_response][:grade_result]

    return false unless token_valid(grades_string)

    grades_json = JSON.parse(grades_string.to_s)
    grades_json['grade']['provisorio']['parciais']
  end

  def self.provisional_final_grades(token)
    response = @client.call(:grade, message: { token: token })
    grades_string = response.body[:grade_response][:grade_result]

    return false unless token_valid(grades_string)

    grades_json = JSON.parse(grades_string.to_s)
    grades_json['grade']['provisorio']['finais']
  end

  def self.definitive_historic_grades(token)
    response = @client.call(:grade, message: { token: token })
    grades_string = response.body[:grade_response][:grade_result]

    return false unless token_valid(grades_string)

    grades_json = JSON.parse(grades_string.to_s)
    grades_json['grade']['definitivo']
  end

  def self.get_assiduity(token)
    response = @client.call(:assiduity, message: { token: token })
    response_string = response.body[:assiduity_response][:assiduity_result]

    return false unless token_valid(response_string)

    response_json = JSON.parse(response_string.to_s)
    response_json['assiduity']
  end

  def self.get_atm(token)
    response = @client.call(:atm, message: { token: token })
    response_string = response.body[:atm_response][:atm_result]

    return false unless token_valid(response_string)

    response_json = JSON.parse(response_string.to_s)
    response_json['atm']
  end

  def self.get_menu(token)
    response = @client.call(:menu, message: { token: token })
    response_string = response.body[:menu_response][:menu_result]

    return false unless token_valid(response_string)

    response_string = response_string.to_s.gsub(/((\d){4}-(\d){2}-(\d){2})/,
                                                '"\1"')
    JSON.parse(response_string.to_s)
  end

  def self.exams(token)
    response = @client.call(:exame, message: { token: token })
    response_string = response.body[:exame_response][:exame_result]

    return false unless token_valid(response_string)

    if valid_json?(response_string)
      response_json = JSON.parse(response_string)
      return response_json['Exames']
    end
    []
  end

  def self.get_schedule(token)
    response = @client.call(:schedule, message: { token: token })
    response_string = response.body[:schedule_response][:schedule_result]

    response_json = JSON.parse(response_string.to_s)
    response_json['schedule']
  end

  def self.get_teachers
    response = @client.call(:docentes)
    response_string = response.body[:docentes_response][:docentes_result]

    response_json = JSON.parse(response_string.to_s)
    response_json['Docentes']
  end

  def self.get_teacher(initials)
    response = @client.call(:docente, message: { sigla: initials })
    response_string = response.body[:docente_response][:docente_result]

    response_json = JSON.parse(response_string.to_s)
    response_json['Docente']
  end

  def self.valid_json?(string)
    !!JSON.parse(string)
  rescue JSON::ParserError
    false
  end

  def self.token_valid(string)
    string == '{"Error": "Not a valid token"}' ? false : true
  end
end
