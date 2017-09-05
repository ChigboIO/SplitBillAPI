class User < ApplicationRecord
  has_secure_password

  has_many :tokens
  has_many :bills
  has_many :splits

  validates :email, :username, :name, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
  }

  def deptors
    bills.map(&:splitters).uniq
  end
end
