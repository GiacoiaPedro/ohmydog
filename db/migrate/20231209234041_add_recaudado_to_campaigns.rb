class AddRecaudadoToCampaigns < ActiveRecord::Migration[7.1]
  def change
    add_column :campaigns, :recaudado, :integer, default: 0
  end
end
