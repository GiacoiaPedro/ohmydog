class CreatePerroPerdidos < ActiveRecord::Migration[7.1]
  def change
    create_table :perro_perdidos do |t|
      t.string :nombre, default: ''
      t.string :sexo
      t.integer :raza_id
      t.string :comportamiento
      t.string :lugar
      t.date :fecha
      t.string :foto
      t.integer :edad
      t.boolean :activa, default: true

      t.timestamps
    end
  end
end
