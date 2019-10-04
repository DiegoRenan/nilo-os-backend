require 'rails_helper'

class Hash 
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo, key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

RSpec.describe V1::TicketsController, type: :controller do

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

  context 'GET v1/tickets/:id' do

    it 'should return an id' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      ticket = create(:ticket)
      get :show, params: {id: ticket.id }
      response_body = JSON.parse(response.body)
      expect(response_body['data'][0]['id']).to eq(ticket.id )
    end
    
  end

  context 'POST v1/tickets' do

    it 'should create a ticket' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      
      company = create(:company)
      department = create(:department)
      sector = create(:sector)
      employee = create(:employee)
      type = create(:ticket_type)
      status = create(:ticket_status)

      ticket = {
        "data": {
          "type": "tickets",
          "attributes": {
              "title": "New Ticket",
              "body": "New Ticket",
              "company_id": "#{company.id}",
              "department_id": "#{department.id}",
              "sector_id": "#{sector.id}",
              "employee_id": "#{employee.id}",
              "ticket_type_id": "#{type.id}",
              "ticket_status_id": "#{ status.id }"
          }
        }
      }

      post :create, params: ticket
      expect(response).to have_http_status(:created)
      response_body = JSON.parse(response.body)
      ticket = JSON.parse(ticket.to_json)
      expect(response_body.json("data > attributes > title")).to eq(ticket.json("data > attributes > title"))
    end

  end

  context 'PUT v1/tickets/:id' do
    
    it 'should update a status status' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      ticket = create(:ticket)
      params = {
        "id": ticket.id,
        "type": "tickets",
        "attributes": {
          "title": "title update"
        }
      }
      put :update, params: { id: ticket.id , data: params }
      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      params = JSON.parse(params.to_json)
      expect(response_body.json("data > attributes > title")).to eq(params.json("attributes > title"))
    end

  end

  context 'DELETE v1/ticket/:id' do
    
    it 'should delete' do 
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      ticket = create(:ticket, title: 'Ticket for del')
      delete :destroy, params: {id: ticket.id }
      expect(response).to have_http_status(:no_content)
      get :show, params: {id: ticket.id }
      expect(Ticket.exists?(ticket.id )).to be_falsey
    end

  end

end