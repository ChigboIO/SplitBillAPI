class Bill < ApplicationRecord
  after_create :split_bill

  belongs_to :creator, class_name: 'User'
  has_many :splits

  serialize :splitters, Array

  def splitters
    splits.map(&:user)
  end

  def split_bill
    # This splitting can be abstracted to a service. Or even a background job
    splitters_count = splitters.count
    splitters.each do |splitter|
      user = User.find_by(username: splitter)
      splits.create(payer: user, amount: (amount / splitters_count).ceil)
    end
  end
end
