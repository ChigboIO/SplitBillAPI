FactoryGirl.define do
  factory :split do
    bill factory: :bill
    payer { bill.payers.first }
    amount { bill.amount.to_f / bill.splitters.count }
  end
end
