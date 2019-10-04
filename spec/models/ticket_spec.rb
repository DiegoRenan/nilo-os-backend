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
#  priority_id      :uuid
#  sector_id        :uuid
#  ticket_status_id :uuid
#  ticket_type_id   :uuid
#
# Indexes
#
#  index_tickets_on_company_id        (company_id)
#  index_tickets_on_department_id     (department_id)
#  index_tickets_on_employee_id       (employee_id)
#  index_tickets_on_priority_id       (priority_id)
#  index_tickets_on_sector_id         (sector_id)
#  index_tickets_on_ticket_status_id  (ticket_status_id)
#  index_tickets_on_ticket_type_id    (ticket_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (department_id => departments.id)
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (priority_id => priorities.id)
#  fk_rails_...  (sector_id => sectors.id)
#  fk_rails_...  (ticket_status_id => ticket_statuses.id)
#  fk_rails_...  (ticket_type_id => ticket_types.id)
#

require 'rails_helper'

RSpec.describe Ticket, type: :model do

  context 'should be valid' do

    it 'create' do
      expect(build(:ticket, title: "Title", body: 'Hello body')).to be_valid
    end

  end

  context 'should not be valid' do
    
    it 'when title is empty' do
      expect(build(:ticket, title: '')).to_not be_valid
    end

    it 'when title is a blank space' do
      expect(build(:ticket, title: '')).to_not be_valid
    end

    it 'when body is empty' do
      expect(build(:ticket, body: '')).to_not be_valid
    end

    it 'when body is a blank space' do
      expect(build(:ticket, body: '')).to_not be_valid
    end

    it 'when title is more then 500 letters' do
      name = 'b' * 501
      expect(build(:ticket, title: name)).to_not be_valid
    end

    it 'when body is more then 20000 letters' do
      name = 'b' * 20001
      expect(build(:ticket, body: name)).to_not be_valid
    end

  end

end
