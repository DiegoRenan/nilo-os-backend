class CreateTicketTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_types, id: :uuid do |t|
      t.string :name, unique: true

      t.timestamps
    end
  end
end
