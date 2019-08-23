require 'rails_helper'

class Hash 
  def json(parts)
    ary = parts.split(">")
    ary.reduce(self) do |memo, key|
      memo.fetch(key.to_s.strip) if memo
    end
  end
end

describe V1::TicketsController, type: :controller do
  
  it 'request index without accept header NOT_ACCEPTABLE' do
    get :index
    expect(response).to have_http_status(:not_acceptable)
  end

  it 'request index with accept header OK' do
    request.accept = 'applicaton/vnd.api+json'
    get :index
    expect(response).to have_http_status(:ok)
  end

  it 'GET v1/tickets/:id' do
    ticket = Ticket.first
    request.accept = 'applicaton/vnd.api+json'
    get :show, params: {id: ticket.id}
    response_body = JSON.parse(response.body)
    expect(response_body.fetch("data").first.fetch("id")).to eq(ticket.id)
  end

end