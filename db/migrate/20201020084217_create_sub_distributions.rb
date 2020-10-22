class CreateSubDistributions < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_distributions, id: :uuid do |t|
      t.references :distribution, type: :uuid, foreign_key: true
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.integer :number_of_equipment

      t.timestamps
    end
  end
end
