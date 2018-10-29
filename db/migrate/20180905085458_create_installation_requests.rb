class CreateInstallationRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :installation_requests do |t|
      t.references :organization_structure, foreign_key: true
      t.references :facility, foreign_key: true
      t.string :equipment_name
      t.string :model
      t.text :installation_description
      t.string :requested_to
      t.integer :request_to_org_structure
      t.integer :request_to_facility
      t.integer :request_to_institution
      t.string :requested_by
      t.date :request_date

      t.timestamps
    end
  end
end
