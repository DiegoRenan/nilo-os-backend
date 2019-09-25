module V1
  class CompanySerializer < ActiveModel::Serializer
    attributes :id, :name
  
    #HATEOAS
    link(:self) { v1_company_url(object.id) }
  end
  
end
