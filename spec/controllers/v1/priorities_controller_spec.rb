require 'rails_helper'

RSpec.describe V1::PrioritiesController, type: :controller do
  
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
end 
