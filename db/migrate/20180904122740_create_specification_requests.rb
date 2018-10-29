class CreateSpecificationRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :specification_requests do |t|
      t.references :organization_structure, foreign_key: true
      t.references :facility, foreign_key: true
      t.string :requested_to
      t.integer :requested_to_org_structure
      t.integer :requested_to_facility
      t.integer :requested_to_institution
      t.string :equipment_name
      t.float :quantity
      t.string :requested_by
      t.date :requested_date

      t.timestamps
    end
  end
end
