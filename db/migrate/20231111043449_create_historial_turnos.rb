class CreateHistorialTurnos < ActiveRecord::Migration[7.1]
  def change
    create_table :historial_turnos do |t|
      t.date :fecha
      t.time :hora
      t.string :franja
      t.references :tipo_turno, foreign_key: true

      t.timestamps
    end
  end
end
