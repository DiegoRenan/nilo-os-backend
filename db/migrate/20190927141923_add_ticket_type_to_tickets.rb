class AddTicketTypeToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :ticket_type, type: :uuid, foreign_key: true
  end
end
