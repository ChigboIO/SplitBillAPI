class Split < ApplicationRecord
  after_create :send_notification_to_payer

  belongs_to :payer, class_name: 'User'
  belongs_to :bill

  delegate :date, to: :bill, allow_nil: true

  validates :amount, :bill, :payer, presence: true

  def payee
    bill.creator
  end

  def send_notification_to_payer
    return if payer == payee
    UserMailer.send_split_notice(self).deliver_now
  end
end
