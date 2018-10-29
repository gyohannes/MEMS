class CreateSparePartRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :spare_part_requests do |t|
      t.references :organization_structure, foreign_key: true
      t.references :facility, foreign_key: true
      t.string :spare_part_name
      t.string :model
      t.integer :volts_ampere
      t.integer :power_requirement
      t.integer :quantity
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
