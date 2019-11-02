# == Schema Information
#
# Table name: employees
#
#  id            :uuid             not null, primary key
#  born          :date
#  cep           :string
#  city          :string
#  cpf           :string
#  district      :string
#  email         :string
#  name          :string
#  number        :string
#  street        :string
#  uf            :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  company_id    :uuid
#  department_id :uuid
#  sector_id     :uuid
#
# Indexes
#
#  index_employees_on_company_id     (company_id)
#  index_employees_on_department_id  (department_id)
#  index_employees_on_sector_id      (sector_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (department_id => departments.id)
#  fk_rails_...  (sector_id => sectors.id)
#

class Employee < ApplicationRecord
  #associations
  belongs_to :company
  belongs_to :department, optional: true
  belongs_to :sector, optional: true

  has_one :user, dependent: :destroy
  
  has_many :tickets

  has_many :responsibles

  has_one_attached :avatar

  #before save
  before_save { self.email = email.downcase }

  #regex
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  #validations
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  validates :cpf, presence: true, length: { is: 11 },
                                  uniqueness: true
  validates :cep, length: { is: 8 }, allow_blank: true

end
