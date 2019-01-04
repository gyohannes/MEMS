class CreateFacilityTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :facility_types, id: :uuid do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
