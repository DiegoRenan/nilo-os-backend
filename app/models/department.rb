# == Schema Information
#
# Table name: departments
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :uuid
#
# Indexes
#
#  index_departments_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#

class Department < ApplicationRecord
  belongs_to :company

  has_many :employees
  has_many :tickets

  #before actions
  before_save { self.name = name.upcase }

  #validations
	validates :name, presence: true, length: { minimum: 2, maximum: 500 }
end
