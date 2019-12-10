class CreateReceiveEquipments < ActiveRecord::Migration[5.1]
  def change
    create_table :receive_equipments, id: :uuid do |t|
      t.references :receive, type: :uuid, foreign_key: true
      t.references :equipment_name, type: :uuid, foreign_key: true
      t.string :model
      t.text :description
      t.integer :quantity
      t.float :unit_cost

      t.timestamps
    end
  end
end
