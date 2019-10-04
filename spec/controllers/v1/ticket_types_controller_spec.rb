require 'rails_helper'

class Hash 
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo, key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

RSpec.describe V1::TicketTypesController, type: :controller do
  before(:each) do
    @current_user = create(:user)
  end
  
  context 'request index' do
    
    it 'without accept header NOT_ACCEPTABLE' do
      get :index
      expect(response).to have_http_status(:not_acceptable)
    end


    it 'should not access without authorization' do
      request.accept = 'applicaton/json'
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

  context 'GET v1/ticket_types/:id' do

    it 'should return an id' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      type = create(:ticket_types)
      request.accept = 'applicaton/vnd.api+json'
      get :show, params: {id: type.id }
      response_body = JSON.parse(response.body)
      expect(response_body.json("data > id")).to eq(type.id )
    end
    
  end

  context 'POST v1/ticket_types' do

    it 'should create a type' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      type = {
        "data": {
          "type": "ticket_types",
          "attributes": {
              "name": "New Type"
          }
        }
      }
      request.accept = 'application/vnd.api+json'
      post :create, params: type
      expect(response).to have_http_status(:created)
      response_body = JSON.parse(response.body)
      type = JSON.parse(type.to_json)
      expect(response_body.json("data > attributes > name")).to eq(type.json("data > attributes > name").upcase)
    end

  end

  context 'PUT v1/ticket_types/:id' do
    
    it 'should update a status status' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      type = create(:ticket_types)
      params = {
        "id": type.id,
        "type": "type-status",
        "attributes": {
          "name": "TicketType update"
        }
      }
      request.accept = 'application/vnd.api+json'
      put :update, params: { id: type.id , data: params }
      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      params = JSON.parse(params.to_json)
      expect(response_body.json("data > attributes > name")).to eq(params.json("attributes > name").upcase)
    end

  end

  context 'DELETE v1/ticket_types/:id' do
    
    it 'should delete a status without tickets' do 
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      type = TicketType.create(name: 'TicketType Without Tickets')
      request.accept = 'application/vnd.api+json'
      delete :destroy, params: {id: type.id }
      expect(response).to have_http_status(:no_content)
      get :show, params: {id: type.id }
      expect(TicketType.exists?(type.id )).to be_falsey
    end

    it 'should not delete a status with tickets' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token 
      type = create(:ticket_types)
      request.accept = 'application/vnd.api+json'
      delete :destroy, params: {id: type.id }
      expect(response).to have_http_status(:conflict)
      get :show, params: {id: type.id }
      expect(TicketType.exists?(type.id )).to be_truthy
    end

  end
end
