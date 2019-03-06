class CreateMaintenanceRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenance_requests, id: :uuid do |t|
      t.references :organization_structure, type: :uuid, foreign_key: true
      t.references :facility, type: :uuid, foreign_key: true
      t.references :equipment, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.string :maintenance_type
      t.text :maintenance_description
      t.string :request_to
      t.references :institution, type: :uuid, foreign_key: true
      t.date :request_date
      t.text :comment
      t.string :decision_by, type: :uuid
      t.string :assigned_to, type: :uuid
      t.string :status
      t.timestamps
    end
  end
end