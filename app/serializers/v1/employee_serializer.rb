class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :born, :cpf, :cep, :street, :number, :district, :city, :uf
  
  belongs_to :company
  belongs_to :department
end
