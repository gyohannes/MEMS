class CreateEquipment < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.references :equipment_name, type: :uuid, foreign_key: true
      t.string :inventory_number
      t.text :description
      t.references :equipment_type, type: :uuid, foreign_key: true
      t.references :department, type: :uuid, foreign_key: true
      t.string :location
      t.date :installation_date
      t.date :warranty_expire_date
      t.string :maintenance_service_provider
      t.string :acquisition_type
      t.string :equipment_risk_classification
      t.string :model
      t.string :order_number
      t.float :cost
      t.string :serial_number
      t.string :tag_number
      t.string :manufacturer
      t.string :country
      t.date :manufactured_year
      t.date :purchased_year
      t.string :volt_ampere
      t.integer :power_requirement
      t.references :maintenance_requirement, type: :uuid, foreign_key: true
      t.integer :estimated_life_span
      t.float :years_used
      t.references :institution, type: :uuid, foreign_key: true
      t.boolean :trained_end_users
      t.boolean :trained_technical_personnel
      t.references :status, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
