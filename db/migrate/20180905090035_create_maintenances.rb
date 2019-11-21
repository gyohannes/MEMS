class CreateMaintenances < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenances, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :equipment, type: :uuid, foreign_key: true
      t.references :maintenance_request, type: :uuid, foreign_key: true
      t.string :maintenance_work_order_id, type: :uuid
      t.text :description_of_equipment_failure
      t.text :cause_of_equipment_failure
      t.text :part_of_equipment_maintained
      t.text :corrective_action
      t.text :spare_parts_used
      t.date :start_date
      t.date :end_date
      t.float :maintenance_cost
      t.string :maintenance_type
      t.references :status, type: :uuid, foreign_key: true
      t.text :engineer_name_and_contact
      t.date :preventive_maintenance_date
      t.text :note

      t.timestamps
    end
  end
end
