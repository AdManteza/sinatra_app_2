class User < ActiveRecord::Base
  has_secure_password

  has_many :tracks
  has_many :votes

  validates :first_name, :last_name, :user_name, :password, presence: true

end