class CreateDistributions < ActiveRecord::Migration[5.2]
  def change
    create_table :distributions, id: :uuid do |t|
      t.references :equipment_name, type: :uuid, foreign_key: true
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.integer :number_of_equipment

      t.timestamps
    end
  end
end
