class CreateVaccines < ActiveRecord::Migration[7.1]
  def change
    create_table :vaccines do |t|
      t.references :vacuna, foreign_key: true
      t.integer :peso
      t.string :texto
      t.references :historial_turno, foreign_key: true

      t.timestamps
    end
  end
end
