class AddConsultaToHistorialTurnos < ActiveRecord::Migration[7.1]
  def change
    add_column :historial_turnos, :consulta, :string
  end
end
