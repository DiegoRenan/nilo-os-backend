class AddCompanyToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :company, type: :uuid, index: true
  end
end
