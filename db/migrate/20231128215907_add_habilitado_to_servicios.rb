class AddHabilitadoToServicios < ActiveRecord::Migration[7.1]
  def change
    add_column :servicios, :habilitado, :integer
  end
end
