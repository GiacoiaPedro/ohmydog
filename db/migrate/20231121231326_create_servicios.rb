class CreateServicios < ActiveRecord::Migration[7.1]
  def change
    create_table :servicios do |t|
      t.string :nombre
      t.string :apellido
      t.integer :dni
      t.string :zona
      t.string :mail
      t.string :tipo
      t.string :horarios

      t.timestamps
    end
  end
end
