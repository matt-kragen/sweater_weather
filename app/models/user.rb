class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_key

  validates :email, uniqueness: true, presence: true
  validates :password_confirmation, presence: true
  validates_confirmation_of :password
end
