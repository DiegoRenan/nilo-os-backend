# == Schema Information
#
# Table name: sectors
#
#  id            :uuid             not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  department_id :uuid
#
# Indexes
#
#  index_sectors_on_department_id  (department_id)
#
# Foreign Keys
#
#  fk_rails_...  (department_id => departments.id)
#

FactoryBot.define do
  factory :sector do
    name { Faker::Commerce.department(max: 2, fixed_amount: true) }
    department
  end
end
