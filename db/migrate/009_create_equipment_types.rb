class CreateEquipmentTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment_types, id: :uuid do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
