require 'rails_helper'

class Hash 
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo, key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

RSpec.describe V1::SectorsController, type: :controller do

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

  context 'GET v1/sectors/:id' do

    it 'should return an id' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      sector = create(:sector)
      get :show, params: {id: sector.id }
      response_body = JSON.parse(response.body)
      expect(response_body['data'][0]['id']).to eq(sector.id)
    end
    
  end

  context 'POST v1/sectors' do

    it 'should create a sector' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      department = create(:department)
      sector = {
        "data": {
          "type": "sectors",
          "attributes": {
              "name": "New sector",
              "department_id": "#{ department.id }"
          }
        }
      }

      post :create, params: sector
      expect(response).to have_http_status(:created)
      response_body = JSON.parse(response.body)
      sector = JSON.parse(sector.to_json)
      expect(response_body.json("data > attributes > name")).to eq(sector.json("data > attributes > name").upcase)
    end

  end

  context 'PUT v1/sectors/:id' do
    
    it 'should update a sector name' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      request.accept = 'application/vnd.api+json'
      sector = create(:sector)

      params = {
        "id": sector.id,
        "type": "sectors",
        "attributes": {
          "name": "Sector updated"
        }
      }

      put :update, params: { id: sector.id, data: params }
      expect(response).to have_http_status(:ok)
      sector = Sector.find(sector.id)
      expect(sector.name).to eq('SECTOR UPDATED')
    end

  end

  context 'DELETE v1/sectors/:id' do
    
    it 'to delete' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      request.accept = 'application/vnd.api+json'
      sector = create(:sector)
      expect {
        delete :destroy, params: { id: sector.id }
      }.to change(Sector, :count).by(-1)
    end

  end

end
