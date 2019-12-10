class CreateInstallationRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :installation_requests, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.references :equipment_name, type: :uuid, foreign_key: true
      t.string :model
      t.text :description
      t.date :request_date
      t.text :comment
      t.string :decision_by, type: :uuid
      t.string :assigned_to, type: :uuid
      t.string :status
      t.timestamps
    end
  end
end
