class CreateEquipmentNames < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment_names do |t|
      t.references :equipment_category, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
