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

require 'rails_helper'

describe Responsible, type: :model do
  
  context 'shoul not be valid' do
    it 'duplicated responsible table' do
      a = Employee.first

      ta = Ticket.first
      
      responsible = Responsible.create(employee_id: a.id, ticket_id: ta.id)
      
      expect(build(:responsible, employee_id: a.id, ticket_id: ta.id)).to_not be_valid
    end
  end

end
