class AddMailToPerroPerdidos < ActiveRecord::Migration[7.1]
  def change
    add_column :perro_perdidos, :mail, :string
  end
end
