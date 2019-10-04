# == Schema Information
#
# Table name: comments
#
#  id          :uuid             not null, primary key
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :uuid
#  ticket_id   :uuid
#
# Indexes
#
#  index_comments_on_employee_id  (employee_id)
#  index_comments_on_ticket_id    (ticket_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (ticket_id => tickets.id)
#

require 'rails_helper'

describe Comment, type: :model do
  
  context 'should be valid' do
    it 'valid comment' do
      e = Employee.first
      t = Ticket.first
      expect(build(:comment, body: 'Hello', employee_id: e.id, ticket_id: t.id)).to be_valid
    end
  end

  context 'should not be valid' do
    
    it 'when comment body is empty' do
      e = Employee.first
      t = Ticket.first
      expect(build(:comment, body: '', employee_id: e.id, ticket_id: t.id)).to_not be_valid
    end

    it 'when comment body is a blank space' do
      e = Employee.first
      t = Ticket.first
      expect(build(:comment, body: ' ', employee_id: e.id, ticket_id: t.id)).to_not be_valid
    end

    it 'when body comment is more then 2000 letters' do
      b = 'a' * 20001
      e = Employee.first
      t = Ticket.first
      expect(build(:comment, body: b, employee_id: e.id, ticket_id: t.id)).to_not be_valid
    end

  end

end
