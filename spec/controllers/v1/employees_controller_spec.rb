require 'rails_helper'

class Hash 
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo, key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

RSpec.describe V1::EmployeesController, type: :controller do

  context 'GET v1/employees' do
    
    it 'without accept header NOT_ACCEPTABLE' do
      get :index
      expect(response).to have_http_status(:not_acceptable)
    end
    
    it 'should access with header' do
      request.accept = 'applicaton/vnd.api+json'
      get :index
      expect(response).to have_http_status(:ok)
    end

  end

  context 'GET v1/employee/:id' do

    it 'should return an id' do
      employee = create(:employee)
      request.accept = 'applicaton/vnd.api+json'
      get :show, params: {id: employee.id}
      response_body = JSON.parse(response.body)
      expect(response_body.json("data > id")).to eq(employee.id)
    end

  end

  context 'POST v1/employee' do

    it 'should create a employee' do
      request.accept = 'application/vnd.api+json'
      company = create(:company)
      
      employee_attributes = {
        "data": {
            "type": "employees",
            "attributes": {
                "name": "Test From rspec",
                "email": "rspectest@moore.com",
                "born": "1968-07-05",
                "cpf": "29845364297",
                "cep": "17409185",
                "street": "Marginal Ana Sophia Teles",
                "number": "11",
                "district": "Khartoum",
                "city": "Frei Martinho",
                "uf": "PI",
                "company_id": "#{company.id}"
            }
        }
      }
      
      expect {
        post :create, params: employee_attributes
      }.to change(Employee, :count).by(1)

    end

  end

  context 'PUT v1/employees/:id' do
    
    it 'should update a company name' do
      request.accept = 'application/vnd.api+json'
      employee = create(:employee)

      params = {
        "id": employee.id,
        "type": "employees",
        "attributes": {
          "name": "Employee updated"
        }
      }

      put :update, params: { id: employee.id, data: params }
      expect(response).to have_http_status(:ok)
      employee = Employee.find(employee.id)
      expect(employee.name).to eq('Employee updated')
    end

  end

  context 'DELETE v1/employees/:id' do
    
    it 'to delete' do
      request.accept = 'application/vnd.api+json'
      employee = create(:employee)
      expect {
        delete :destroy, params: { id: employee.id }
      }.to change(Employee, :count).by(-1)
    end

  end

end
