# == Schema Information
#
# Table name: ticket_statuses
#
#  id         :uuid             not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :ticket_status do
    status { Faker::Color.color_name }
  end
end
