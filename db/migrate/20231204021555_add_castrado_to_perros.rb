class AddCastradoToPerros < ActiveRecord::Migration[7.1]
  def change
    add_column :perros, :castrado, :boolean, default: false
  end
end
