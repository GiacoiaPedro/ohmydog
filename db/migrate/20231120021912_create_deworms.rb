class CreateDeworms < ActiveRecord::Migration[7.1]
  def change
    create_table :deworms do |t|
      t.integer :cantidad
      t.string :texto
      t.references :historial_turno, foreign_key: true

      t.timestamps
    end
  end
end
