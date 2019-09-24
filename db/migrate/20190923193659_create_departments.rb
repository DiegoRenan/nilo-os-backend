class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments, id: :uuid do |t|
      t.string :name
      t.references :company, type: :uuid, foreign_key: true


      t.timestamps
    end
  end
end
