FactoryGirl.define do
  factory :split do
    bill factory: :bill
    payer { bill.payers.first if bill }
    amount { bill.amount.to_f / bill.splitters.count if bill }
  end
end
