class CreateMaintenances < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenances, id: :uuid do |t|
      t.references :equipment, type: :uuid, foreign_key: true
      t.string :maintenance_type
      t.text :problem
      t.text :action_taken
      t.text :spare_parts_used
      t.date :start_date
      t.date :end_date
      t.float :maintenance_cost
      t.string :maintained_by
      t.string :contact_address
      t.date :preventive_maintenance_date
      t.text :note

      t.timestamps
    end
  end
end
