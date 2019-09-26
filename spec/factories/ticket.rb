FactoryBot.define do
  factory :ticket do
    title { Faker::Company.name }
    body { Faker::Lorem.paragraph(2, false, 4) }
    conclude_at { Faker::Date.between(20.days.ago, 30.days.from_now) }
    company
    ticket_status
  end
end