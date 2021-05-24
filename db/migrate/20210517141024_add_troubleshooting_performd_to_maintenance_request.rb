class AddTroubleshootingPerformdToMaintenanceRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :maintenance_requests, :troubleshooting_performed, :text
  end
end
