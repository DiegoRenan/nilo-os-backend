require 'rails_helper'

RSpec.describe V1::ResponsiblesController, type: :controller do
  
  before(:each) do
    @current_user = create(:user)
  end

  context 'POST v1/responsibles' do

    it 'should create a responsibles' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      request.accept = 'application/vnd.api+json'
      
      ticket = create(:ticket)
      employee = create(:employee)

      responsible_attributes = {
        "data": {
            "type": "responsibles",
            "attributes": {
              "ticket_id": "#{ticket.id}",
              "employee_id": "#{employee.id}"
            }
        }
      }
      
      expect {
        post :create, params: responsible_attributes
      }.to change(Responsible, :count).by(1)

    end
  end

  context 'DELETE v1/responsibles/:id' do
    
    it 'should delete' do 
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      responsible = create(:responsible)
      delete :destroy, params: {id: responsible.id }
      expect(response).to have_http_status(:no_content)
      expect(Responsible.exists?(responsible.id )).to be_falsey
    end

  end
end
