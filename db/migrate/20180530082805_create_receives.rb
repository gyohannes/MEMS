class CreateReceives < ActiveRecord::Migration[5.1]
  def change
    create_table :receives, id: :uuid do |t|
      t.references :store, type: :uuid, foreign_key: true
      t.string :bin_number
      t.string :equipment_name
      t.string :model
      t.string :deliverer_name
      t.string :recipient_name
      t.text :recipient_contact_address
      t.boolean :with_full_checklist
      t.string :witness_name
      t.string :witness_contact_address
      t.integer :quantity
      t.float :unit_cost
      t.date :delivery_date
      t.text :note

      t.timestamps
    end
  end
end
