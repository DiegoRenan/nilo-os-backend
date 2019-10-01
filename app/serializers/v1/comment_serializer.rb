class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :employee, :created

  def created
    I18n.l object.created_at
  end

  def employee
    object.employee.name
  end

  belongs_to :ticket
  belongs_to :employee
end
