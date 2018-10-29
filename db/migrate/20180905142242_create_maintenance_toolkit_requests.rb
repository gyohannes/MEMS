class CreateMaintenanceToolkitRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenance_toolkit_requests do |t|
      t.references :organization_structure, foreign_key: true
      t.references :facility, foreign_key: true
      t.string :toolkit_name
      t.text :toolkit_description
      t.float :quantity
      t.string :requested_to
      t.integer :request_to_org_structure
      t.integer :request_to_facility
      t.string :requested_by
      t.text :contact_address
      t.date :request_date

      t.timestamps
    end
  end
end
