class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments, id: :uuid do |t|
      t.text :body
      t.references :employee, type: :uuid, foreign_key: true
      t.references :ticket, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
