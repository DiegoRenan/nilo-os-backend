FactoryBot.define do
  factory :comment do
    text { "" }
    employee { nil }
    ticket { nil }
  end
end
