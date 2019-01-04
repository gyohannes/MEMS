class CreateProcurementRequestEquipments < ActiveRecord::Migration[5.1]
  def change
    create_table :procurement_request_equipments, id: :uuid do |t|
      t.references :procurement_request, type: :uuid, foreign_key: true
      t.string :equipment_name
      t.text :specification
      t.integer :quantity
      t.integer :approved_quantity

      t.timestamps
    end
  end
end
