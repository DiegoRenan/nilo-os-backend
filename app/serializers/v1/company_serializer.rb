module V1
  class CompanySerializer < ActiveModel::Serializer
    attributes :id, :name
  
    #Associations
    has_many :tickets do 
      link(:related) {v1_company_tickets_url(object.id)}
    end

    has_many :employees
  
    #HATEOAS
    link(:self) { v1_company_url(object.id) }
  end
  
end
