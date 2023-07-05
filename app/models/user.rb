class User < ApplicationRecord
  has_secure_password
  
  has_many :training_logs

  validates :name, :email, :password_digest, presence: true
  validates :name, length: { maximum: 30 }
end