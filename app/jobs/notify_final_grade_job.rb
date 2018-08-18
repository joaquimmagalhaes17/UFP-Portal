class NotifyFinalGradeJob < ApplicationJob
  queue_as :default

  def perform(user, curricular_unit, epoch, oral_ex, write_ex, final_grade, consultation_date, oral_date)
    if user.email_notification
      BotMailer.final_grade(user, curricular_unit, epoch, oral_ex, write_ex, final_grade, consultation_date, oral_date).deliver_now
    end

    if user.sms_notification and user.contact.to_s.length > 0
      sms_notification(user, curricular_unit, epoch, oral_ex, write_ex, final_grade, consultation_date, oral_date)
    end

    push_notification(user.id, curricular_unit, epoch, oral_ex, write_ex, final_grade, consultation_date, oral_date)
  end

  private

  def sms_notification(user, curricular_unit, epoch, oral_ex, write_ex, final_grade, consultation_date, oral_date)
    text = "Nova nota provisória.\r\nUnidade: #{curricular_unit}\r\nEpoca: #{epoch}" +
           "\r\nExame Oral: #{oral_ex}\r\nExame Escrito: #{write_ex}" +
           "\r\nNota: #{final_grade}\r\nConsulta: #{consultation_date}\r\n" +
           "Data Oral: #{oral_date}\r\nI know, I'm awesome ❤️"

    NotificationsHelper.send_sms(user.contact, text)
  end

  def push_notification(user_id, curricular_unit, epoch, oral_ex, write_ex, final_grade, consultation_date, oral_date)
    text = "Epoca: #{epoch}" +
        "\r\nExame Oral: #{oral_ex}\r\nExame Escrito: #{write_ex}" +
        "\r\nNota: #{final_grade}\r\nConsulta: #{consultation_date}\r\n" +
        "Data Oral: #{oral_date}\r\nI know, I'm awesome ❤️"

    devices_id = DeviceId.where(user_id: user_id).pluck('device_id').to_a

    unless devices_id.empty?
      NotificationsHelper.send_push_notification(devices_id,
                                                 curricular_unit, text)
    end
  end
end
