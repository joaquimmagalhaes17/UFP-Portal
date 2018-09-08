# frozen_string_literal: true

class Analysis
  def initialize(user)
    @user = user
    @soap_handler = SOAPHandler
  end

  def start
    if @user.tokens.nil? || @user.tokens.empty?
      refresh_tokens
    else
      @tokens = @user.tokens
    end

    partial_grades
    final_grades

    User.update(@user.id, first_usage: false) if @user.first_usage
  end

  private

  def refresh_tokens
    @tokens = @soap_handler.login(
      @user.student_number,
      CipherHelper.decrypt(@user.password)
    )

    @user.update!(tokens: @tokens)
    @user.reload
  end

  def partial_grades
    grades = @soap_handler.provisional_partial_grades(@tokens)

    unless grades
      refresh_tokens
      grades = @soap_handler.provisional_partial_grades(@tokens)
    end

    grades = JSON.parse(grades) if grades.is_a? String

    return unless grades

    grades.each do |grade|
      partial_grade_exists(grade['AnoLectivo'], grade['Unidade'], grade['Elemento'], grade['Nota'])
    end
  end

  def partial_grade_exists(year, unit, element, grade)
    result = PartialGrade.find_by(user_id: @user.id, unit: unit, element: element, grade: grade, year: year)
    if result.nil?
      unless @user.first_usage
        NotifyPartialGradeJob.perform_later(@user, unit, element, grade)
      end

      PartialGrade.new(user_id: @user.id, unit: unit, element: element, grade: grade, year: year).save
    end
  end

  def final_grades
    grades = @soap_handler.provisional_final_grades(@tokens)

    unless grades
      refresh_tokens
      grades = @soap_handler.provisional_final_grades(@tokens)
    end

    grades = JSON.parse(grades) if grades.is_a? String

    return unless grades

    grades.each do |grade|
      final_grade_exists(
        grade['Unidade'],
        grade['Epoca'],
        grade['NotaOral'],
        grade['Exame'],
        grade['Nota'],
        grade['Consulta'],
        grade['Oral']
      )
    end
  end

  def final_grade_exists(curricular_unit, epoch, oral_ex, write_ex, final_grade, consultation_date, oral_date)
    result = FinalGrade.find_by(
      user_id: @user.id,
      unit: curricular_unit,
      epoch: epoch,
      oral_ex: oral_ex,
      write_ex: write_ex,
      consultation_date: consultation_date,
      oral_date: oral_date,
      grade: final_grade
    )

    if result.nil?
      unless @user.first_usage
        NotifyFinalGradeJob.perform_later(@user, curricular_unit, epoch, oral_ex, write_ex, final_grade, consultation_date, oral_date)
      end

      FinalGrade.new(
        user_id: @user.id,
        unit: curricular_unit,
        epoch: epoch,
        oral_ex: oral_ex,
        write_ex: write_ex,
        consultation_date: consultation_date,
        oral_date: oral_date,
        grade: final_grade
      ).save
    end
  end
end
