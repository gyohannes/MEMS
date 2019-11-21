class CreateModelEquipments < ActiveRecord::Migration[5.1]
  def change
    create_table :model_equipments, id: :uuid do |t|
      t.references :model_equipment_list, type: :uuid, foreign_key: true
      t.references :equipment_name, type: :uuid, foreign_key: true
      t.references :equipment_type, type: :uuid, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
