# frozen_string_literal: true

class DeviceId < ApplicationRecord
  validates :device_id, presence: true, uniqueness: true
  validates :user_id, presence: true
end
