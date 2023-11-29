class UpdateDefaultDonanteValue < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :donante, from: nil, to: false
  end
end
