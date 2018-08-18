module Api
  class FirebaseController < ApiController
    def register_device_id
      device_id = params[:device_id]
      user_number = params[:user_number]
      unless user_number.nil?
        user = User.find_by(student_number: user_number)
        unless user.nil?
          entry = DeviceId.new(device_id: device_id, user_id: user.id)
          if entry.valid?
            entry.save
            return render json: 'Added device_id'.to_json, status: 201
          end
        end
      end

      render json: 'Invalid device_id or student number'.to_json, status: 400
    end

    def update_device_id
      device_id = params[:new_device_id]
      old_device_id = params[:old_device_id]
      user_number = params[:user_number]

      unless old_device_id.nil? || device_id.nil? || user_number.nil?
        user = User.find_by(student_number: user_number)
        unless user.nil?
          device = DeviceId.find_by(device_id: old_device_id, user_id: user.id)
          unless device.nil?
            DeviceId.update(device.id, device_id: device_id)
            return render json: 'Updated device_id'.to_json, status: 200
          end
        end
      end

      render json: 'Missing field'.to_json, status: 400
    end

    def remove_device_id
      device_id = params[:device_id]
      user_number = params[:user_number]

      unless device_id.nil? || user_number.nil?
        user = User.find_by(student_number: user_number)
        unless user.nil?
          device = DeviceId.find_by(device_id: device_id, user_id: user.id)
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

