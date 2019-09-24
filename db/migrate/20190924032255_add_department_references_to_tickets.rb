class AddDepartmentReferencesToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :department,  type: :uuid, foreign_key: true
  end
end
