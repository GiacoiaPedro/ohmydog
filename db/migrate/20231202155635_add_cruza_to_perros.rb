class AddCruzaToPerros < ActiveRecord::Migration[7.1]
  def change
    add_column :perros, :cruza, :boolean, default: false
  end
end
