class AddMontoToHistorialTurnos < ActiveRecord::Migration[7.1]
  def change
    add_column :historial_turnos, :monto, :integer
  end
end
