class AddSectorReferencesToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_reference :employees, :sector, type: :uuid, foreign_key: true
  end
end
