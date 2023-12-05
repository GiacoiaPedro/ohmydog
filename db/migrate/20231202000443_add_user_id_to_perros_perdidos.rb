class AddUserIdToPerrosPerdidos < ActiveRecord::Migration[7.1]
  def change
    add_column :perro_perdidos, :user_id, :integer
  end
end
