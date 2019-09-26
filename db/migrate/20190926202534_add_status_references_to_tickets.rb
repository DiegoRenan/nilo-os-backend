class AddStatusReferencesToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :ticket_status, type: :uuid, foreign_key: true
  end
end