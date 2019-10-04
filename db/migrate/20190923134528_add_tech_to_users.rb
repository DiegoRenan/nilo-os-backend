class AddTechToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tec, :boolean, :default => true
  end
end
