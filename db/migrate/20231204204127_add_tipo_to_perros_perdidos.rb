class AddTipoToPerrosPerdidos < ActiveRecord::Migration[7.1]
  def change
    add_column :perro_perdidos, :tipo, :integer
  end
end
