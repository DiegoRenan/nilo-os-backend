# == Schema Information
#
# Table name: sectors
#
#  id            :uuid             not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  department_id :uuid
#
# Indexes
#
#  index_sectors_on_department_id  (department_id)
#
# Foreign Keys
#
#  fk_rails_...  (department_id => departments.id)
#

require 'rails_helper'

RSpec.describe Sector, type: :model do
  context 'should be valid' do

    it 'when 2 letters' do
      expect(create(:sector, name: "TI")).to be_valid
    end

    it 'when 500 letters' do
      name = 'a' * 500
      expect(create(:sector, name: name)).to be_valid
    end

    it 'when LOWER AND UPCASE letters' do
      expect(create(:sector, name: 'Sector')).to be_valid
    end

  end

  context 'should not be valid' do
    
    it 'when name is empty' do
      expect(build(:sector, name: '')).to_not be_valid
    end

    it 'when name is a blank space' do
      expect(build(:sector, name: '')).to_not be_valid
    end

    it 'when name is less then 2 letters' do
      expect(build(:sector, name: 'b')).to_not be_valid
    end

    it 'when name is more then 500 letters' do
      name = 'b' * 501
      expect(build(:sector, name: name)).to_not be_valid
    end
  
  end

end
