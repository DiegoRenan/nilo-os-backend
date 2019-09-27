# == Schema Information
#
# Table name: ticket_types
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe TicketType, type: :model do
  context 'should be valid' do

    it 'when 2 letters' do
      expect(TicketType.create(name: 'TI')).to be_valid
    end

    it 'when 200 letters' do
      name = 'a' * 200
      expect(TicketType.create(name: name)).to be_valid
    end

    it 'when LOWER AND UPCASE letters' do
      expect(TicketType.create(name: 'Type')).to be_valid
    end

  end

  context 'should not be valid' do
    
    it 'when name is empty' do
      expect(TicketType.create(name: '')).to_not be_valid
    end

    it 'when name is a blank space' do
      expect(TicketType.create(name: ' ')).to_not be_valid
    end

    it 'when name is less then 2 letters' do
      expect(TicketType.create(name: 'b')).to_not be_valid
    end

    it 'when name is more then 200 letters' do
      name = 'b' * 201
      expect(TicketType.create(name: name)).to_not be_valid
    end

    it 'when name is not unique' do
      name = TicketType.create(name: 'matriz')
      name_duplicate = TicketType.first
      expect(TicketType.create(name: name_duplicate.name)).to_not be_valid
    end

  end

  it 'should be saved in UPCASE' do
    name = create(:ticket_type, name: 'name')
    expect(name.name).to eq('NAME')
  end
end
