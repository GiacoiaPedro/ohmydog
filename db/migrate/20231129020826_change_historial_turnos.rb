class ChangeHistorialTurnos < ActiveRecord::Migration[7.1]
  def change
    remove_column :historial_turnos, :fecha_y_hora
    add_column :historial_turnos, :fecha, :date
    add_column :historial_turnos, :hora, :time
  end
end