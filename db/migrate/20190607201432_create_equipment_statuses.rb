class CreateEquipmentStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment_statuses, id: :uuid do |t|
      t.references :equipment, type: :uuid, foreign_key: true
      t.references :status, type: :uuid, foreign_key: true
      t.text :remark

      t.timestamps
    end
  end
end
