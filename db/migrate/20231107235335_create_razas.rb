class CreateRazas < ActiveRecord::Migration[7.1]
  def change
    create_table :razas do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
