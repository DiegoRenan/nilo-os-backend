require 'rails_helper'

class Hash 
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo, key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

RSpec.describe V1::CommentsController, type: :controller do
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

  context 'GET v1/comments/:id' do

    it 'should return an id' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      comment = create(:comment)
      get :show, params: {id: comment.id}
      response_body = JSON.parse(response.body)
      expect(response_body['data'][0]['id']).to eq(comment.id)
    end
    
  end

  context 'POST v1/comments' do

    it 'should create a comment' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      e = create(:employee)
      t = create(:ticket)
      comment = {
        "data": {
          "type": "comments",
          "attributes": {
              "body": "New Company",
              "ticket_id": t.id,
              "employee_id": e.id
          }
        }
      }
      post :create, params: comment
      expect(response).to have_http_status(:created)
      response_body = JSON.parse(response.body)
      comment = JSON.parse(comment.to_json)
      expect(response_body.json("data > attributes > body")).to eq(comment.json("data > attributes > body"))
    end

  end

  context 'PUT v1/comments/:id' do
    
    it 'should update a comment body' do
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      comment = create(:comment)
      params = {
        "id": comment.id,
        "type": "comments",
        "attributes": {
          "body": "Comment update"
        }
      }
      request.accept = 'application/vnd.api+json'
      put :update, params: { id: comment.id, data: params }
      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      params = JSON.parse(params.to_json)
      expect(response_body.json("data > attributes > body")).to eq(params.json("attributes > body"))
    end
  
  end

  context 'DELETE v1/comments/:id' do
    
    it 'should delete a comment' do 
      request.accept = 'applicaton/vnd.api+json'
      request.headers.merge! @current_user.create_new_auth_token
      comment = create(:comment)
      delete :destroy, params: {id: comment.id}
      expect(response).to have_http_status(:no_content)
      get :show, params: {id: comment.id}
      expect(Comment.exists?(comment.id)).to be_falsey
    end

  end


end
