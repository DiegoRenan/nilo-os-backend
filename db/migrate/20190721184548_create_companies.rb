class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies, id: :uuid do |t|
      t.string :name, unique: true

      t.timestamps
    end
  end
end
