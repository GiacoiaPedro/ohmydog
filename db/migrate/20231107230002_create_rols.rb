class CreateRols < ActiveRecord::Migration[7.1]
  def change
    create_table :rols do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
