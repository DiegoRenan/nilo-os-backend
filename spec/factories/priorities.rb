# == Schema Information
#
# Table name: priorities
#
#  id         :uuid             not null, primary key
#  nivel      :string           default("plan")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :priority do
    nivel { Faker::Company.name }
  end
end
