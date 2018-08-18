require 'base64'
require 'gibberish'

module CipherHelper
  @key = ENV["cipher_key"]

  def self.encrypt(string)
    cipher = Gibberish::AES.new(@key)
    encrypted = cipher.encrypt(string)
    Base64.urlsafe_encode64(encrypted)
  end

  def self.decrypt(string)
    cipher = Gibberish::AES.new(@key)
    encrypted = Base64.urlsafe_decode64(string)
    cipher.decrypt(encrypted)
  end
end