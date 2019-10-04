# == Schema Information
#
# Table name: ticket_types
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :ticket_type do
    name { Faker::Color.color_name }
  end
end
