class AddEncontradoToPerrosPerdidos < ActiveRecord::Migration[7.1]
  def change
    add_column :perro_perdidos, :encontrado, :boolean, default: false
  end
end
