class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments, id: :uuid do |t|
      t.body :text
      t.references :employee, foreign_key: true
      t.references :ticket, foreign_key: true

      t.timestamps
    end
  end
end
