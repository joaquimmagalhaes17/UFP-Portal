# frozen_string_literal: true

require 'rest-client'
require 'json'
require 'rpush'

module NotificationsHelper
  @content = ''
  @templates = {
    normal: '\r\nI know, I am awesome ❤️',
    short: 'Tem uma nova nota mas não é possivel notificar por aqui, verifique o seu email.'
  }

  def self.send_sms(contact, body)
    msg = "#{body}\r\nI know, I am awesome ❤️"
    data = JSON.dump(to: contact, body: msg, encoding: 'UNICODE')

    puts data

    headers = {
      'Content-Type': 'application/json',
      'Authorization': ENV['bulk_sms_key']
    }

    RestClient.post(
      'https://api.bulksms.com/v1/messages', data, headers
    )
  end

  def self.send_push_notification(devices_id, title, body)
    unless Rpush::Gcm::App.find_by_name('ufp-app')
      app = Rpush::Gcm::App.new
      app.name = 'ufp-app'
      app.auth_key = ENV['firebase_key']
      app.connections = 1
      app.save!
    end

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name('ufp-app')
    n.registration_ids = devices_id
    n.data = { message: body }
    n.priority = 'high'
    n.content_available = true
    n.notification = { body: body,
                       title: title }
    n.save!
    Rpush.push
  end
end
