class AddDepartmentReferencesToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_reference :employees, :department,  type: :uuid, foreign_key: true
  end
end
