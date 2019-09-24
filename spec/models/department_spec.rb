# == Schema Information
#
# Table name: departments
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :uuid
#
# Indexes
#
#  index_departments_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#

require 'rails_helper'

describe V1::Department, type: :model do
  context 'should be valid' do

    it 'when 2 letters' do
      expect(create(:department, name: "TI")).to be_valid
    end

    it 'when 500 letters' do
      name = 'a' * 500
      expect(create(:department, name: name)).to be_valid
    end

    it 'when LOWER AND UPCASE letters' do
      expect(create(:department, name: 'Department')).to be_valid
    end

  end

  context 'should not be valid' do
    
    it 'when name is empty' do
      expect(build(:department, name: '')).to_not be_valid
    end

    it 'when name is a blank space' do
      expect(build(:department, name: '')).to_not be_valid
    end

    it 'when name is less then 2 letters' do
      expect(build(:department, name: 'b')).to_not be_valid
    end

    it 'when name is more then 500 letters' do
      name = 'b' * 501
      expect(build(:department, name: name)).to_not be_valid
    end

  end

  it 'should be saved in UPCASE' do
    department = create(:department, name: 'department')
    expect(department.name).to eq('DEPARTMENT')
  end

end
