class User < ApplicationRecord
  has_secure_password

  has_many :tokens
  has_many :bills, foreign_key: :creator_id
  has_many :splits, foreign_key: :payer_id

  validates :email, :username, :name, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
  }

  def deptors
    bills.map(&:splitters).uniq
  end
end
