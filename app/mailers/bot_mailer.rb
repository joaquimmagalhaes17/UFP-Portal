class BotMailer < ApplicationMailer
  def partial_grade(user, unit, element, grade)
    @unit = unit
    @element = element
    @grade = grade
    mail(to: user.email, subject: unit.to_s)
  end

  def final_grade(user, curricular_unit, epoch, oral_ex, write_ex, final_grade, consultation_date, oral_date)
    @unit = curricular_unit
    @epoch = epoch
    @oral_ex = oral_ex
    @write_ex = write_ex
    @final_grade = final_grade
    @consultation_date = consultation_date
    @oral_date = oral_date
    mail(to: user.email, subject: curricular_unit.to_s)
  end
end
