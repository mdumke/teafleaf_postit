class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :posts
  has_many :comments

  validates :username, presence: true
  validates :password, presence: true, confirmation: true
end
