class CreateSpecifications < ActiveRecord::Migration[5.1]
  def change
    create_table :specifications, id: :uuid do |t|
      t.references :organization_unit_type, type: :uuid, foreign_key: true
      t.references :specification_request, type: :uuid, foreign_key: true
      t.references :equipment_name, type: :uuid, foreign_key: true
      t.references :department, type: :uuid, foreign_key: true
      t.text :item_detail

      t.timestamps
    end
  end
end
