FactoryGirl.define do
  factory :split do
    bill factory: :bill
    payer { bill.payers.last if bill }
    amount { bill.amount.to_f / bill.splitters.count if bill }
  end
end
