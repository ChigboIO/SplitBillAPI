class User < ApplicationRecord
  has_secure_password

  has_many :tokens

  validates :email, :username, :name, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
  }
end
