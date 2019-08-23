class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets, id: :uuid do |t|
      t.string :title
      t.text :body
      t.date :conclude_at

      t.timestamps
    end
  end
end
