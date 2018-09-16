module Api
  class FirebaseController < ApiController
    def register_device_id
      device_id = params[:device_id]
      serial_number = params[:sn]
      user_number = params[:user_number]
      unless user_number.nil?
        user = User.find_by(student_number: user_number)
        unless user.nil?
          device = DeviceId.find_by(serial_number: serial_number, user_id: user.id)
          unless device.nil?
            DeviceId.update(device.id, device_id: device_id)
            return render json: 'Updated device_id'.to_json, status: 200
          end

          entry = DeviceId.new(device_id: device_id, user_id: user.id, serial_number: serial_number)
          if entry.valid?
            entry.save
            return render json: 'Added device_id'.to_json, status: 201
          end
        end
      end

      render json: 'Invalid device_id or student number'.to_json, status: 400
    end

    def remove_device_id
      serial_number = params[:sn]
      user_number = params[:user_number]

      unless serial_number.nil? || user_number.nil?
        user = User.find_by(student_number: user_number)
        unless user.nil?
          device = DeviceId.find_by(serial_number: serial_number, user_id: user.id)
          unless device.nil?
            device.destroy
            return render json: 'Removed device_id'.to_json, status: 200
          end
        end
      end

      render json: 'Missing field'.to_json, status: 400
    end
  end
end
