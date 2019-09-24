class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :company do
    link(:related) { v1_department_company_url(object.id) }
  end

end
