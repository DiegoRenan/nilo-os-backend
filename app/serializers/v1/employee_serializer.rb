class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :born, :cpf, :cep, :street, :number, :district, :city, :uf
  
  belongs_to :company do
    link(:related) { v1_employee_company_url(object.id) }
  end

end
