# == Schema Information
#
# Table name: companies
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ApplicationRecord
  #Associations
  has_many :tickets
  has_many :employees
  has_many :departments
  
  #before actions
  before_save { self.name = name.upcase }

  #validations
	validates :name, presence: true, length: { minimum: 2, maximum: 500 }, uniqueness: { case_sensitive: false }
end
