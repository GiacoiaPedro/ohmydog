class CreateTipoTurnos < ActiveRecord::Migration[7.1]
  def change
    create_table :tipo_turnos do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
