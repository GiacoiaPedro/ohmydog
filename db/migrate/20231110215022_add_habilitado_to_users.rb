class AddHabilitadoToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :habilitado, :boolean , default: true
  end
end
