# frozen_string_literal: true

class NotifyPartialGradeJob < ApplicationJob
  queue_as :default

  def perform(user, unit, element, grade)
    if user.email_notification
      BotMailer.partial_grade(user, unit, element, grade).deliver_now
    end

    if user.sms_notification && !user.contact.to_s.empty?
      sms_notification(user, unit, element, grade)
    end

    push_notification(user, unit, element, grade)
  end

  private

  def sms_notification(user, unit, element, grade)
    text = "#{unit}\r\nElemento: #{element}\r\nNota: #{grade}"

    puts text
    NotificationsHelper.send_sms(user.contact, text)
  end

  def push_notification(user, unit, element, grade)
    text = "Elemento: #{element}\nNota: #{grade}\nI know, I'm awesome ❤️"

    devices_id = DeviceId.where(user_id: user.id).pluck('device_id').to_a

    unless devices_id.empty?
      NotificationsHelper.send_push_notification(devices_id,
                                                 unit, text)
    end
  end
end
