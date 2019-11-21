class CreatePlannedPreventiveMaintenaces < ActiveRecord::Migration[5.2]
  def change
    create_table :planned_preventive_maintenaces, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :equipment, type: :uuid, foreign_key: true
      t.text :action_taken
      t.date :maintained_date
      t.float :maintenace_cost
      t.text :engineer_name_and_address
      t.date :next_ppm
      t.text :note

      t.timestamps
    end
  end
end
