class CreateSectors < ActiveRecord::Migration[5.2]
  def change
    create_table :sectors, id: :uuid do |t|
      t.string :name
      t.references :department,  type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
