# == Schema Information
#
# Table name: tickets
#
#  id            :uuid             not null, primary key
#  body          :text
#  conclude_at   :date
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  company_id    :uuid
#  department_id :uuid
#
# Indexes
#
#  index_tickets_on_company_id     (company_id)
#  index_tickets_on_department_id  (department_id)
#
# Foreign Keys
#
#  fk_rails_...  (department_id => departments.id)
#

class Ticket < ApplicationRecord
  #Associations
  belongs_to :company do
    #HATEOAS 
    link(:related) { v1_ticket_company_url(object.id)}
  end

  belongs_to :department, optional: true

  #Validations
  validates :title, presence: true, length: { minimum: 6, maximum: 500 }
  validates :body, presence: true, length: { minimum: 6, maximum: 20000 }
end
