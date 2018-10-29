class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :facilities do |t|
      t.references :organization_structure, foreign_key: true
      t.string :name
      t.references :facility_type, foreign_key: true
      t.string :category
      t.string :url
      t.integer :latitude
      t.integer :longitude
      t.integer :population
      t.text :note

      t.timestamps
    end
  end
end
