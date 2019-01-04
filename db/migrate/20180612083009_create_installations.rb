class CreateInstallations < ActiveRecord::Migration[5.1]
  def change
    create_table :installations, id: :uuid do |t|
      t.references :equipment, type: :uuid, foreign_key: true
      t.references :department, type: :uuid, foreign_key: true
      t.string :block_number
      t.date :date_of_intallation
      t.string :warranty_period
      t.date :preventive_maintenance_date
      t.string :installed_by
      t.string :contact_address
      t.float :installation_cost
      t.text :note

      t.timestamps
    end
  end
end
