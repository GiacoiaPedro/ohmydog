class AddPerroToHistorialTurno < ActiveRecord::Migration[7.1]
  def change
    add_reference :historial_turnos, :perro,  foreign_key: true
  end
end
