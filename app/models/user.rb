class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, on: :create
  validates :student_number, presence: true, uniqueness: true, on: :create
  validates :password, presence: true
end
