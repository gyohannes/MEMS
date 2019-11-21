class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :facilities, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.string :name
      t.string :code
      t.references :facility_type, type: :uuid, foreign_key: true
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
