class CreateHistorialVacunas < ActiveRecord::Migration[7.1]
  def change
    create_table :historial_vacunas do |t|
      t.date :fecha
      t.references :vacuna, foreign_key: true

      t.timestamps
    end
  end
end
