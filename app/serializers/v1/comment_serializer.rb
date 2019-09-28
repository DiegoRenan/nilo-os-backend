class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body

  belongs_to :ticket
  belongs_to :employee
end
