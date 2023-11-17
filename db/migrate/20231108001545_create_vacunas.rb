class CreateVacunas < ActiveRecord::Migration[7.1]
  def change
    create_table :vacunas do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
