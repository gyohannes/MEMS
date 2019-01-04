class CreateEquipment < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment, id: :uuid do |t|
      t.references :facility, type: :uuid, foreign_key: true
      t.string :equipment_name
      t.references :equipment_category, type: :uuid, foreign_key: true
      t.string :model
      t.string :serial_number
      t.string :tag_number
      t.string :volt_ampere
      t.integer :power_requirement
      t.string :manufacturer
      t.string :country
      t.date :manufactured_year
      t.date :purchased_year
      t.float :purchase_price
      t.integer :supplier_id
      t.boolean :manual_attached
      t.text :warranty_agreement_note
      t.integer :local_representative_id
      t.text :remark
      t.string :status

      t.timestamps
    end
  end
end
