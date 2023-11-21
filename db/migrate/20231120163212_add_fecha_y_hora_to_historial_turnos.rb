class AddFechaYHoraToHistorialTurnos < ActiveRecord::Migration[7.1]
  def change
    add_column :historial_turnos, :fecha_y_hora, :datetime
  end
end
