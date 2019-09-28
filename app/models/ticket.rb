# == Schema Information
#
# Table name: tickets
#
#  id               :uuid             not null, primary key
#  body             :text
#  conclude_at      :date
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  company_id       :uuid
#  department_id    :uuid
#  employee_id      :uuid
#  sector_id        :uuid
#  ticket_status_id :uuid
#  ticket_type_id   :uuid
#
# Indexes
#
#  index_tickets_on_company_id        (company_id)
#  index_tickets_on_department_id     (department_id)
#  index_tickets_on_employee_id       (employee_id)
#  index_tickets_on_sector_id         (sector_id)
#  index_tickets_on_ticket_status_id  (ticket_status_id)
#  index_tickets_on_ticket_type_id    (ticket_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (department_id => departments.id)
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (sector_id => sectors.id)
#  fk_rails_...  (ticket_status_id => ticket_statuses.id)
#  fk_rails_...  (ticket_type_id => ticket_types.id)
#

class Ticket < ApplicationRecord
  
  #Associations
  belongs_to :company do
    #HATEOAS 
    link(:related) { v1_ticket_company_url(object.id)}
  end

  belongs_to :department, optional: true
  belongs_to :sector, optional: true
  belongs_to :ticket_status
  belongs_to :ticket_type
  belongs_to :employee

  has_many :responsibles, dependent: :destroy
  has_many :employees, :through => :responsibles
  has_many :comments, dependent: :destroy

  #Validations
  validates :title, presence: true, length: { minimum: 6, maximum: 500 }
  validates :body, presence: true, length: { minimum: 6, maximum: 20000 }
end
