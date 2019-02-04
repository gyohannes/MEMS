class CreateSpecifications < ActiveRecord::Migration[5.1]
  def change
    create_table :specifications, id: :uuid do |t|
      t.references :organization_structure, type: :uuid, foreign_key: true
      t.references :facility, type: :uuid, foreign_key: true
      t.references :specification_request, type: :uuid, foreign_key: true
      t.string :equipment_name
      t.string :model
      t.text :description
      t.string :approximate_cost
      t.string :specification_by
      t.string :contact_address
      t.date :specification_date

      t.timestamps
    end
  end
end
