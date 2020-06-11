class CreateMaintenanceRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenance_requests, id: :uuid do |t|
      t.references :equipment, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.date :failure_date
      t.text :description_of_problem
      t.string :equipment_status, type: :uuid
      t.references :institution, type: :uuid, foreign_key: true
      t.text :comment
      t.string :decision_by, type: :uuid
      t.string :status
      t.timestamps
    end
  end
end
