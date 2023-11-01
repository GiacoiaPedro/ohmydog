class CreateUsuarios < ActiveRecord::Migration[7.1]
  def change
    create_table :usuarios do |t|
      t.integer :dni
      t.string :nombre
      t.string :apellido
      t.string :rol

      t.timestamps
    end
  end
end
