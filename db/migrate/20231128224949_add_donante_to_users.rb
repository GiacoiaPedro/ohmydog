class AddDonanteToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :donante, false
  end
end
