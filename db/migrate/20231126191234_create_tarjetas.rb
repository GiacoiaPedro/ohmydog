class CreateTarjetas < ActiveRecord::Migration[7.1]
  def change
    create_table :tarjetas do |t|
      t.integer :numero
      t.string :nombre
      t.integer :codigo
      t.integer :monto
      t.date :vencimiento
      t.integer :dni

      t.timestamps
    end
  end
end
