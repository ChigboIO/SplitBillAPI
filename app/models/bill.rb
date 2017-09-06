class Bill < ApplicationRecord
  before_save :sanitize_splitters
  after_save :split_bill

  belongs_to :creator, class_name: 'User'
  has_many :splits, dependent: :destroy
  has_many :payers, through: :splits

  validates :amount, :title, :creator, presence: true

  private

  def sanitize_splitters
    splitters.reject! { |s| User.find_by(username: s).nil? }
    splitters << creator.username
    splitters.uniq!
  end

  def split_bill
    # This splitting can be abstracted to a service. Or even a background job
    splitters_count = splitters.count
    splitters.each do |splitter|
      create_or_update_split_for(splitter, splitters_count)
    end
  end

  def create_or_update_split_for(splitter, splitters_count)
    user = User.find_by(username: splitter)
    split = splits.find_or_initialize_by(payer: user)
    split.amount = (amount.to_f / splitters_count).ceil
    split.paid = true if user == creator
    split.save
  end
end
