class CreateModelEquipmentList < ActiveRecord::Migration[5.1]
  def change
    create_table :model_equipment_list, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
