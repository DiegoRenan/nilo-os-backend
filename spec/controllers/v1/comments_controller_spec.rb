require 'rails_helper'

class Hash 
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo, key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

describe V1::CommentsController, type: :controller do
  
  before(:each) do
    @current_user = create(:user)
  end

  context 'request comments index' do
    
    it 'without accept header NOT_ACCEPTABLE' do
      get :show
      puts response
      # expect(response).to have_http_status(:not_acceptable)
    end

  end

end
