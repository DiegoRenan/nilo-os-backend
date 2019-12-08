class EmployeeSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, 
  					 :name, 
  					 :email, 
  					 :avatar, 
  					 :born, 
  					 :cpf, 
  					 :cep, 
  					 :street, 
  					 :number, 
  					 :district, 
  					 :city, 
  					 :uf,
             :master,
  					 :company_id,
  					 :department_id,
  					 :sector_id
  
  has_many :tickets

  def avatar
    url_for(object.avatar) if object.avatar.attached?
  end

  def master
    object.user.master?
  end
  
end
