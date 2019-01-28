class CreateMaintenanceToolkitRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenance_toolkit_requests, id: :uuid do |t|
      t.references :organization_structure, type: :uuid, foreign_key: true
      t.references :facility, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.string :toolkit_name
      t.text :toolkit_description
      t.float :quantity
      t.string :request_to
      t.text :contact_address
      t.date :request_date
      t.text :comment
      t.string :decision_by, type: :uuid
      t.string :status
      t.timestamps
    end
  end
end
