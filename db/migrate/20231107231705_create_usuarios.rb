class CreateUsuarios < ActiveRecord::Migration[7.1]
  def change
    create_table :usuarios do |t|
      t.integer :dni 
      t.string :nombre
      t.string :apellido
      t.date :fecha_nacimiento
      t.string :mail
      t.string :telefono
      t.references :rol, null: false, foreign_key: true
      t.timestamps
    end
  end
end
