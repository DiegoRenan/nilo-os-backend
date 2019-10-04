class AddSectorReferencesToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :sector, type: :uuid, foreign_key: true
  end
end
