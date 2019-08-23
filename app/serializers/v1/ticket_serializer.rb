module V1
  class TicketSerializer < ActiveModel::Serializer
    attributes :id, :title, :body, :conclude_at
  
    #Associations
    belongs_to :company do
      #HATEOAS 
      link(:related) { v1_ticket_company_url(object.id) }
    end
  
    #HATEOAS
    link(:self) { v1_ticket_url(object.id) }
  
    def attributes(*args)
      h = super(*args)
      h[:conclude_at] = object.conclude_at.to_time.iso8601 unless object.conclude_at.blank?
      h
    end
  end  
end
