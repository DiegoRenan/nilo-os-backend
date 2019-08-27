# == Schema Information
#
# Table name: employees
#
#  id         :uuid             not null, primary key
#  born       :date
#  cep        :string
#  city       :string
#  cpf        :string
#  district   :string
#  email      :string
#  name       :string
#  number     :string
#  street     :string
#  uf         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :uuid
#
# Indexes
#
#  index_employees_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#

class Employee < ApplicationRecord
  #associations
  belongs_to :company
  #validations
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :cpf, presence: true, length: { is: 11 }
  validates :cep, length: { is: 8 }, allow_blank: true
end
