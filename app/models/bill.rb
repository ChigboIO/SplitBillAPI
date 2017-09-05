class Bill < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :splits

  serialize :splitters, Array

  def splitters
    splits.map(&:user)
  end
end
