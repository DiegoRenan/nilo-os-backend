FactoryBot.define do
  factory :department do
    name { Faker::Commerce.department(max: 2, fixed_amount: true) }
    company
  end
end
