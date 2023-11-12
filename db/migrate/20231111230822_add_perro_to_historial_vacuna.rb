class AddPerroToHistorialVacuna < ActiveRecord::Migration[7.1]
  def change
    add_reference :historial_vacunas, :perro,  foreign_key: true
  end
end
