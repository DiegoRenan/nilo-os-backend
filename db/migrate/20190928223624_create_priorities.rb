class CreatePriorities < ActiveRecord::Migration[5.2]
  def change
    create_table :priorities, id: :uuid do |t|
      t.string :nivel, default: "plan"

      t.timestamps
    end
  end
end
