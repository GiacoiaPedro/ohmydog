# db/migrate/YYYYMMDDHHMMSS_add_activa_to_campaigns.rb

class AddActivaToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :activa, :boolean, default: true
  end
end
