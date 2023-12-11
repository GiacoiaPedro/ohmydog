class RemoveVacunaIdFromVaccines < ActiveRecord::Migration[7.1]
  def change
    remove_column :vaccines, :vacuna_id, :integer
  end
end
