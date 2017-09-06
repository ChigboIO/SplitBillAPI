FactoryGirl.define do
  factory :bill do
    creator factory: :user
    amount { Faker::Number.number(4).to_i }
    title { Faker::Lorem.sentence }
    splitters do
      FactoryGirl.create_list(:user, 2).pluck(:username)
    end
  end
end
