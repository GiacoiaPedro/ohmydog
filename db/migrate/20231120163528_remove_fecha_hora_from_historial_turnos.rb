class RemoveFechaHoraFromHistorialTurnos < ActiveRecord::Migration[7.1]
  def change
    remove_column :historial_turnos, :fecha, :date
    remove_column :historial_turnos, :hora, :time
  end
end
