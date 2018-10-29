class CreateProcurementRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :procurement_requests do |t|
      t.references :organization_structure, foreign_key: true
      t.references :facility, foreign_key: true
      t.references :user, foreign_key: true
      t.string :contact_phone
      t.string :contact_email
      t.string :request_to

      t.timestamps
    end
  end
end
