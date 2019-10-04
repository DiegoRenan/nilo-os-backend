FactoryBot.define do
  factory :ticket do
    title { Faker::Company.name }
    body { Faker::Lorem.paragraph }
    conclude_at { Faker::Date.between(from: 20.days.ago, to: 30.days.from_now) }
    company
    department
    sector
    employee
    ticket_status
    ticket_type
    priority
  end
end