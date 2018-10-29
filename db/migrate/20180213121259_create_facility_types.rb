class CreateFacilityTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :facility_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
