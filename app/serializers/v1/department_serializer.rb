class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :company
  has_many :sectors
end
