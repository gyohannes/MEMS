class CreateSpareParts < ActiveRecord::Migration[5.1]
  def change
    create_table :spare_parts, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.references :equipment_name, type: :uuid, foreign_key: true
      t.string :name
      t.string :item_code_number
      t.text :description
      t.string :uom
      t.integer :max_stock_level
      t.integer :min_reorder_level
      t.string :lead_time
      t.integer :order_quantity

      t.timestamps
    end
  end
end
