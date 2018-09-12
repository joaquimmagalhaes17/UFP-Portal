# frozen_string_literal: true

module Api
  class AdminController < ApiController
    def get_users
      users = User.select('id', 'name', 'email', 'student_number', 'contact', 'email_notification', 'sms_notification').to_a

      render json: AdminHelper.parse_to_table(users).to_json, status: 200
    end

    def get_user_details
      if params[:id].nil?
        return render json: {
          status: 'Error',
          message: 'Missing user id'
        }.to_json, status: 404
      end

      user = User.select('id', 'name', 'email', 'student_number', 'contact', 'email_notification', 'sms_notification', 'enable').find(params[:id])

      if user.nil?
        return render json: {
          status: 'Error',
          message: 'User not found'
        }.to_json, status: 404
      end

      render json: {
        status: 'Ok',
        message: user
      }.to_json, status: 200
    end

    ###
    # This endpoint uses the admin middleware logic.
    #
    # @return [Object]
    def is_admin
      render json: {
        status: 'Ok',
        message: true
      }.to_json, status: 200
    end

    def update_user
      user = User.find_by(student_number: params[:information][:student_number])
      user.update!(
        email: params[:information][:email],
        contact: params[:information][:contact],
        name: params[:information][:name],
        email_notification: params[:information][:email_notification],
        enable: params[:information][:enable],
        sms_notification: params[:information][:sms_notification]
      )

      render json: {
          status: 'Ok',
          message: 'User details updated'
      }.to_json, status: 200
    end

    def remove_user
      user = User.find_by(student_number: params[:student_number])
      PartialGrade.where(user_id: user.id).delete_all
      FinalGrade.where(user_id: user.id).delete_all
      DeviceId.where(user_id: user.id).delete_all
      user.delete

      render json: {
          status: 'Ok',
          message: 'User removed'
      }.to_json, status: 200
    end
  end
end
