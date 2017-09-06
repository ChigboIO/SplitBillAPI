class Split < ApplicationRecord
  belongs_to :payer, class_name: 'User'
  belongs_to :bill

  delegate :date, to: :bill, allow_nil: true

  validates :amount, :bill, :payer, presence: true

  def payee
    bill.creator
  end
end
