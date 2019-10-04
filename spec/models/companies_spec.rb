require 'rails_helper'

describe V1::Company, type: :model do
  
  context 'should be valid' do

    it 'when 2 letters' do
      expect(Company.create(name: 'TI')).to be_valid
    end

    it 'when 500 letters' do
      name = 'a' * 500
      expect(Company.create(name: name)).to be_valid
    end

    it 'when LOWER AND UPCASE letters' do
      expect(Company.create(name: 'Department')).to be_valid
    end

  end

  context 'should not be valid' do
    
    it 'when name is empty' do
      expect(Company.create(name: '')).to_not be_valid
    end

    it 'when name is a blank space' do
      expect(Company.create(name: ' ')).to_not be_valid
    end

    it 'when name is less then 2 letters' do
      expect(Company.create(name: 'b')).to_not be_valid
    end

    it 'when name is more then 500 letters' do
      name = 'b' * 501
      expect(Company.create(name: name)).to_not be_valid
    end

    it 'when name is not unique' do
      company = Company.create(name: 'matriz')
      company_duplicate = Company.first
      expect(Company.create(name: company_duplicate.name)).to_not be_valid
    end

  end

  it 'should be saved in UPCASE' do
    company = create(:company, name: 'company')
    expect(company.name).to eq('COMPANY')
  end

end