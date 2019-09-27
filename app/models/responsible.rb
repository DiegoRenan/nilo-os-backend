# == Schema Information
#
# Table name: responsibles
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :uuid
#  ticket_id   :uuid
#
# Indexes
#
#  index_responsibles_on_employee_id  (employee_id)
#  index_responsibles_on_ticket_id    (ticket_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (ticket_id => tickets.id)
#

class Responsible < ApplicationRecord
  belongs_to :employee
  belongs_to :ticket

  validates :ticket_id, uniqueness: { scope: :employee_id }
end
