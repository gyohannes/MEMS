class CreateSparePartRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :spare_part_requests, id: :uuid do |t|
      t.references :organization_structure, type: :uuid, foreign_key: true
      t.references :facility, type: :uuid, foreign_key: true
      t.string :spare_part_name
      t.string :model
      t.integer :volts_ampere
      t.integer :power_requirement
      t.integer :quantity
      t.string :request_to
      t.references :institution, type: :uuid, foreign_key: true
      t.string :requested_by
      t.date :request_date
      t.string :status
      t.timestamps
    end
  end
end
