class CreateProcurementRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :procurement_requests, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.string :contact_phone
      t.string :contact_email
      t.date :request_date
      t.text :comment
      t.string :decision_by, type: :uuid
      t.string :status

      t.timestamps
    end
  end
end
