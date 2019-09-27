FactoryBot.define do
  factory :employee do
    name  { Faker::Name.name }
    cpf { Faker::Number.number(digits: 11) }
    born { Faker::Date.birthday(min_age: 18, max_age: 65) }
    email { Faker::Internet.email }
    street { Faker::Address.street_name }
    number { Faker::Number.number(digits: 2) }
    district { Faker::Nation.capital_city } 
    city { Faker::Address.city }
    uf { Faker::Address.state_abbr }
    cep { Faker::Number.number(digits: 8) }
    
    company
    user
  end
end
