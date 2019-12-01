class EmployeeSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
    
  attributes :id, :name, :email, :avatar, :born, :cpf, :cep, :street, :number, :district, :city, :uf
  
  belongs_to :company
  belongs_to :department
  belongs_to :sector
  
  has_many :tickets

  def avatar
    url_for(object.avatar) if object.avatar.attached?
  end
  
end
