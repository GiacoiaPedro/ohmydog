class AddDescuentoToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :descuento, :integer
  end
end
