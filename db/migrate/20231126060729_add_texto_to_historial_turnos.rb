class AddTextoToHistorialTurnos < ActiveRecord::Migration[7.1]
  def change
    add_column :historial_turnos, :texto, :string
  end
end
