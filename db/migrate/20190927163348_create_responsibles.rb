class CreateResponsibles < ActiveRecord::Migration[5.2]
  def change
    create_table :responsibles, id: :uuid do |t|
      t.references :employee, type: :uuid, foreign_key: true
      t.references :ticket, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
