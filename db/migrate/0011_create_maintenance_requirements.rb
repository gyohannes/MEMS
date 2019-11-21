class CreateMaintenanceRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :maintenance_requirements, id: :uuid do |t|
      t.string :name
      t.integer :days

      t.timestamps
    end
  end
end
