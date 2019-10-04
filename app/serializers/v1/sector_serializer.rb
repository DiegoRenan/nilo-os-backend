class SectorSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :department
  has_many :employees
end
