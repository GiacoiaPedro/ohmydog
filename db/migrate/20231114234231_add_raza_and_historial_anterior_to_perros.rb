class AddRazaAndHistorialAnteriorToPerros < ActiveRecord::Migration[7.1]
  def change
    add_reference :perros, :raza, foreign_key: true
    add_column :perros, :historial_anterior, :string
  end
end
