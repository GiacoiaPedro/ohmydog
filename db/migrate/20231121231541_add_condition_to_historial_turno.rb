class AddConditionToHistorialTurno < ActiveRecord::Migration[7.1]
  def change
    add_reference :historial_turnos, :condition, foreign_key: true
  end
end
