class CreateMaintenanceRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenance_requests, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.references :equipment, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.date :failure_date
      t.text :description_of_problem
      t.references :status, type: :uuid, foreign_key: true
      t.references :institution, type: :uuid, foreign_key: true
      t.string :decision_by, type: :uuid
      t.string :request_status
      t.timestamps
    end
  end
end
