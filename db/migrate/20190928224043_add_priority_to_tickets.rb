class AddPriorityToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :priority, type: :uuid, foreign_key: true
  end
end
