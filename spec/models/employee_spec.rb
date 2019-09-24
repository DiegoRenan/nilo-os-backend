# == Schema Information
#
# Table name: employees
#
#  id            :uuid             not null, primary key
#  born          :date
#  cep           :string
#  city          :string
#  cpf           :string
#  district      :string
#  email         :string
#  name          :string
#  number        :string
#  street        :string
#  uf            :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  company_id    :uuid
#  department_id :uuid
#
# Indexes
#
#  index_employees_on_company_id     (company_id)
#  index_employees_on_department_id  (department_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (department_id => departments.id)
#

require 'rails_helper'

describe V1::Employee, type: :model do
  context 'should be valid' do

    it 'with full datas' do
      employee = create(:employee)
      expect(employee).to be_valid
    end

    it 'without cep' do
      employee = build(:employee, cep: nil)
      expect(employee).to be_valid
    end

  end

  context 'is invalid' do
    
    it 'without name' do
      employee = build(:employee, name: nil)
      employee.valid?
      expect(employee.errors[:name]).to include("não pode ficar em branco")
    end

    it 'without email' do
      employee = build(:employee, email: nil)
      employee.valid?
      expect(employee.errors[:email]).to include("não pode ficar em branco")
    end

    it 'without cpf' do
      employee = build(:employee, cpf: nil)
      employee.valid?
      expect(employee.errors[:cpf]).to include("não pode ficar em branco")
    end

    it 'name too long' do
      name = 'a' * 101
      employee = build(:employee, name: name)
      employee.valid?
      expect(employee.errors[:name]).to include(/é muito longo/)
    end

    it 'email too long' do
      email = 'a' * 256 + '@mail.com'
      employee = build(:employee, email: email)
      employee.valid?
      expect(employee.errors[:email]).to include(/é muito longo/)
    end

    it 'cpf less than 11' do
      cpf = '1' * 10
      employee = build(:employee, cpf: cpf)
      employee.valid?
      expect(employee.errors[:cpf]).to include(/não possui o tamanho esperado/)
    end

    it 'cpf more than 11' do
      cpf = '1' * 12
      employee = build(:employee, cpf: cpf)
      employee.valid?
      expect(employee.errors[:cpf]).to include(/não possui o tamanho esperado/)
    end

    it 'cep less than 8' do
      cep = 'a' * 7
      employee = build(:employee, cep: cep)
      employee.valid?
      expect(employee.errors[:cep]).to include(/não possui o tamanho esperado/)
    end

    it 'cep more than 8' do
      cep = 'a' * 9
      employee = build(:employee, cep: cep)
      employee.valid?
      expect(employee.errors[:cep]).to include(/não possui o tamanho esperado/)
    end

  end

  context 'associations' do

    it 'belong_to company' do
      employee = create(:employee)
      expect(employee.company_id?).to be_truthy
    end

  end

end
