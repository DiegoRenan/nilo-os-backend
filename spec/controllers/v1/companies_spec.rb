require 'rails_helper'

class Hash 
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo, key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

describe V1::CompaniesController, type: :controller do

  before(:each) do
    @current_user = create(:user)
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

  context 'GET v1/companies/:id' do

    it 'should return an id' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      company = Company.first
      request.accept = 'applicaton/vnd.api+json'
      get :show, params: {id: company.id}
      response_body = JSON.parse(response.body)
      expect(response_body.json("data > id")).to eq(company.id)
    end
    
  end

  context 'POST v1/company' do

    it 'should create a company' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      company = {
        "data": {
          "type": "companies",
          "attributes": {
              "name": "New Company"
          }
        }
      }
      request.accept = 'application/vnd.api+json'
      post :create, params: company
      expect(response).to have_http_status(:created)
      response_body = JSON.parse(response.body)
      company = JSON.parse(company.to_json)
      expect(response_body.json("data > attributes > name")).to eq(company.json("data > attributes > name").upcase)
    end

  end

  context 'PUT v1/companies/:id' do
    
    it 'should update a company name' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      company = Company.first
      params = {
        "id": company.id,
        "type": "companies",
        "attributes": {
          "name": "Company update"
        }
      }
      request.accept = 'application/vnd.api+json'
      put :update, params: { id: company.id, data: params }
      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      params = JSON.parse(params.to_json)
      expect(response_body.json("data > attributes > name")).to eq(params.json("attributes > name").upcase)
    end

  end

  context 'DELETE v1/company/:id' do
    
    it 'should delete a company without tickets' do 
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      company = Company.create(name: 'Company Without Tickets')
      request.accept = 'application/vnd.api+json'
      delete :destroy, params: {id: company.id}
      expect(response).to have_http_status(:no_content)
      get :show, params: {id: company.id}
      expect(Company.exists?(company.id)).to be_falsey
    end

    it 'should not delete a company with tickets' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token 
      company = Company.first
      request.accept = 'application/vnd.api+json'
      delete :destroy, params: {id: company.id}
      expect(response).to have_http_status(:conflict)
      get :show, params: {id: company.id}
      expect(Company.exists?(company.id)).to be_truthy
    end

  end

  # def login
  #   request.accept = 'application/json'
  #   post '/auth/sign_in', params:  { email: @current_user.email, password: @current_user.password }
  # end

end