class AnadirDonanteToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :donante, :boolean, default: false
  end
end
