class PrioritySerializer < ActiveModel::Serializer
  attributes :id, :nivel

  has_many :tickets
end
