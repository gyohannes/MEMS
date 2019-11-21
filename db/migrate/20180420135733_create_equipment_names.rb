class CreateEquipmentNames < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment_names, id: :uuid do |t|
      t.references :equipment_type, type: :uuid, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
