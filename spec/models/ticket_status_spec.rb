# == Schema Information
#
# Table name: ticket_statuses
#
#  id         :uuid             not null, primary key
#  status     :string           default("ABERTO")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe TicketStatus, type: :model do
  context 'should be valid' do

    it 'when 2 letters' do
      expect(TicketStatus.create(status: 'TI')).to be_valid
    end

    it 'when 200 letters' do
      status = 'a' * 200
      expect(TicketStatus.create(status: status)).to be_valid
    end

    it 'when LOWER AND UPCASE letters' do
      expect(TicketStatus.create(status: 'Status')).to be_valid
    end

  end

  context 'should not be valid' do
    
    it 'when status is empty' do
      expect(TicketStatus.create(status: '')).to_not be_valid
    end

    it 'when status is a blank space' do
      expect(TicketStatus.create(status: ' ')).to_not be_valid
    end

    it 'when status is less then 2 letters' do
      expect(TicketStatus.create(status: 'b')).to_not be_valid
    end

    it 'when status is more then 200 letters' do
      status = 'b' * 201
      expect(TicketStatus.create(status: status)).to_not be_valid
    end

    it 'when status is not unique' do
      status = TicketStatus.create(status: 'matriz')
      status_duplicate = TicketStatus.first
      expect(TicketStatus.create(status: status_duplicate.status)).to_not be_valid
    end

  end

  it 'should be saved in UPCASE' do
    status = create(:ticket_status, status: 'status')
    expect(status.status).to eq('STATUS')
  end

end
