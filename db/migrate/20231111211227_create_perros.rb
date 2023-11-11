class CreatePerros < ActiveRecord::Migration[7.1]
  def change
    create_table :perros do |t|
      t.string :nombre
      t.integer :edad
      t.date :fecha_nacimiento
      t.string :sexo
      t.references :historial_vacuna, foreign_key: true
      t.references :historial_turno,  foreign_key: true
      t.references :raza, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
