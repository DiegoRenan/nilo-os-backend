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
             :company_name,
             :department_id,
             :department_name,
             :sector_id,
             :sector_name
  
  has_many :tickets

  def avatar
    url_for(object.avatar) if object.avatar.attached?
  end

  def master
    object.user.master?
  end

  def company_name
    object.company.name
  end

  def department_name
    object.department&.name
  end

  def sector_name
    object.sector&.name
  end
  
end
