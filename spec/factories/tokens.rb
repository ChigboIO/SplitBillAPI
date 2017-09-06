FactoryGirl.define do
  factory :token do
    user factory: :user
    value { "#{Faker::Internet.password}.#{Faker::Internet.password}.#{Faker::Internet.password}" }
  end
end
