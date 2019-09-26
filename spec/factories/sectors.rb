FactoryBot.define do
  factory :sector do
    name { Faker::Commerce.department(max: 2, fixed_amount: true) }
    department
  end
end
