class BotMailer < ApplicationMailer
  def partial_grade(user, unit, element, grade)
    @unit = unit
    @element = element
    @grade = grade
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end

  def final_grade(user, curricular_unit, epoch, oral_ex, write_ex, final_grade, consultation_date, oral_date)
    @unit = curricular_unit
    @epoch = epoch
    @oral_ex = oral_ex
    @write_ex = write_ex
    @final_grade = final_grade
    @consultation_date = consultation_date
    @oral_date = oral_date
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end
end
