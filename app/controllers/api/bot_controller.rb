# frozen_string_literal: true

require 'json'

module Api
  class BotController < ApiController
    def registered
      token = JSON.parse(CipherHelper.decrypt(params[:token]))
      user = User.select('name, email, student_number, contact').find_by(
        student_number: token['username']
      )

      if user.nil?
        return render json: {
          status: 'Error',
          message: 'Not found'
        }.to_json, status: 404
      end

      render json: {
        status: 'Ok',
        message: user
      }.to_json, status: 200
    end

    def register
      user = User.new(
        name: params[:name],
        email: params[:email],
        student_number: params[:student_number],
        password: params[:password].nil? ? '' : CipherHelper.encrypt(params[:password]),
        contact: params[:contact]
      )

      unless user.valid?
        return render json: {
          status: 'Error',
          message: user.errors.messages
        }, status: 400
      end

      user.save!

      render json: {
        status: 'Ok',
        message: 'User registered'
      }.to_json, status: 201
    end

    def update
      if params[:student_number].nil? || params[:student_number].empty?
        return render json: {
          status: 'Error',
          message: 'Missing fields'
        }.to_json, status: 400
      end

      user = User.find_by(student_number: params[:student_number])

      if user.nil?
        return render json: {
          status: 'Error',
          message: 'User not found'
        }.to_json, status: 404
      end

      unless SOAPHandler.login user.student_number, params[:password]
        return render json: {
          status: 'Error',
          message: 'Invalid password'
        }.to_json, status: 401
      end

      user.update!(
        email: params[:email],
        contact: params[:contact],
        name: params[:name],
        password: CipherHelper.encrypt(params[:password])
      )

      render json: {
        status: 'Ok',
        message: 'User details updated'
      }.to_json, status: 200
    end
  end
end
