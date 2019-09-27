class AddEmployeeToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :employee, type: :uuid, foreign_key: true
  end
end
