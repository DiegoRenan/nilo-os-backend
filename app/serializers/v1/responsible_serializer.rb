class ResponsibleSerializer < ActiveModel::Serializer
  attributes :id, :employee, :ticket

  def employee
    employee = Employee.find(object.employee_id)
    {id: object.employee_id, name: employee.name}
  end

  def ticket
    {id: object.ticket_id}
  end
  
end
