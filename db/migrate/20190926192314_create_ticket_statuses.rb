class CreateTicketStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_statuses, id: :uuid do |t|
      t.string :status, :default => "ABERTO", unique: true

      t.timestamps
    end
  end
end
