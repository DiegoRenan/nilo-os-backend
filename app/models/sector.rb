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

class Sector < ApplicationRecord
  belongs_to :department

  has_many :tickets
  has_many :employees

  #before actions
  before_save { self.name = name.upcase }

  #validations
  validates :name, presence: true, length: { minimum: 2, maximum: 500 }
end
