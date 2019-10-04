require 'rails_helper'

class Hash 
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo, key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

RSpec.describe V1::DepartmentsController, type: :controller do
  
  before(:each) do
    @current_user = create(:user)
    @company = create(:company)
    @department = create(:department)
  end
  
  context 'request index' do
    
    it 'without accept header NOT_ACCEPTABLE' do
      get :index
      expect(response).to have_http_status(:not_acceptable)
    end


    it 'should not access without authorization' do
      request.accept = 'applicaton/vnd.api+json'
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
    
    it 'should access with header and authorization' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      get :index
      expect(response).to have_http_status(:ok)
    end

  end

  context 'GET v1/departments/:id' do

    it 'should return an id' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      get :show, params: {id: @department.id }
      response_body = JSON.parse(response.body)
      expect(response_body['data'][0]['id']).to eq(@department.id)
    end
    
  end

  context 'POST v1/department' do

    it 'should create a department' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
     
      department = {
        "data": {
          "type": "department",
          "attributes": {
              "name": "New department",
              "company_id": "#{ @company.id }"
          }
        }
      }

      post :create, params: department
      expect(response).to have_http_status(:created)
      response_body = JSON.parse(response.body)
      department = JSON.parse(department.to_json)
      expect(response_body.json("data > attributes > name")).to eq(department.json("data > attributes > name").upcase)
    end

  end

  context 'PUT v1/departments/:id' do
    
    it 'should update a department name' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      request.accept = 'application/vnd.api+json'
      
      params = {
        "id": @department.id,
        "type": "departments",
        "attributes": {
          "name": "Department updated"
        }
      }

      put :update, params: { id: @department.id, data: params }
      expect(response).to have_http_status(:ok)
      department = Department.find(@department.id)
      expect(department.name).to eq('DEPARTMENT UPDATED')
    end

  end

  context 'DELETE v1/departments/:id' do
    
    it 'to delete' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      request.accept = 'application/vnd.api+json'
      department = create(:department)
      expect {
        delete :destroy, params: { id: @department.id }
      }.to change(Department, :count).by(-1)
    end

  end

end
