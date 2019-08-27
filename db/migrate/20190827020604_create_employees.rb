class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees, id: :uuid do |t|
      t.string :name
      t.string :cpf, unique: true
      t.date :born
      t.string :email, unique: true
      t.string :street
      t.string :number
      t.string :district
      t.string :city
      t.string :uf
      t.string :cep
      t.references :company, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
