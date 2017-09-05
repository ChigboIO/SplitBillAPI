class Split < ApplicationRecord
  belongs_to :payer, class_name: 'User'
  belongs_to :bill

  delegate :date, to: :bill, allow_nil: true

  def payee
    bill.creator
  end
end
