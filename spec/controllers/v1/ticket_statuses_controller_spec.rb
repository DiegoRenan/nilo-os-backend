require 'rails_helper'

class Hash 
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo, key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

describe V1::TicketStatusesController, type: :controller do
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

  context 'GET v1/ticket_statuses/:id' do

    it 'should return an id' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      status = TicketStatus.first
      request.accept = 'applicaton/vnd.api+json'
      get :show, params: {id: status.id}
      response_body = JSON.parse(response.body)
      expect(response_body.json("data > id")).to eq(status.id)
    end
    
  end

  context 'POST v1/ticket_statuses' do

    it 'should create a status' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      status = {
        "data": {
          "type": "ticket-statuses",
          "attributes": {
              "status": "New Status"
          }
        }
      }
      request.accept = 'application/vnd.api+json'
      post :create, params: status
      expect(response).to have_http_status(:created)
      response_body = JSON.parse(response.body)
      status = JSON.parse(status.to_json)
      expect(response_body.json("data > attributes > status")).to eq(status.json("data > attributes > status").upcase)
    end

  end

  context 'PUT v1/ticket_statuses/:id' do
    
    it 'should update a status status' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      status = TicketStatus.first
      params = {
        "id": status.id,
        "type": "companies",
        "attributes": {
          "status": "TicketStatus update"
        }
      }
      request.accept = 'application/vnd.api+json'
      put :update, params: { id: status.id, data: params }
      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      params = JSON.parse(params.to_json)
      expect(response_body.json("data > attributes > status")).to eq(params.json("attributes > status").upcase)
    end

  end

  context 'DELETE v1/ticket_statuses/:id' do
    
    it 'should delete a status without tickets' do 
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      status = TicketStatus.create(status: 'TicketStatus Without Tickets')
      request.accept = 'application/vnd.api+json'
      delete :destroy, params: {id: status.id}
      expect(response).to have_http_status(:no_content)
      get :show, params: {id: status.id}
      expect(TicketStatus.exists?(status.id)).to be_falsey
    end

    it 'should not delete a status with tickets' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token 
      status = TicketStatus.first
      request.accept = 'application/vnd.api+json'
      delete :destroy, params: {id: status.id}
      expect(response).to have_http_status(:conflict)
      get :show, params: {id: status.id}
      expect(TicketStatus.exists?(status.id)).to be_truthy
    end

  end

end
