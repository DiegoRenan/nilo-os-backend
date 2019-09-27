FactoryBot.define do
  factory :ticket do
    title { Faker::Company.name }
    body { Faker::Lorem.paragraph }
    conclude_at { Faker::Date.between(20.days.ago, 30.days.from_now) }
    company
    ticket_status
    ticket_type
  end
end