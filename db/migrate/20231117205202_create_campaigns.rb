class CreateCampaigns < ActiveRecord::Migration[7.1]
  def change
    create_table :campaigns do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :monto
      t.string :imagen
      t.date :fecha

      t.timestamps
    end
  end
end
