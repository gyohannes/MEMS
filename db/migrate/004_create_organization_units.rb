class CreateOrganizationUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :organization_units, id: :uuid do |t|
      t.string :name
      t.string :code
      t.references :organization_unit_type, type: :uuid, foreign_key: true
      t.string :parent_organization_unit_id, type: :uuid
      t.boolean :facility
      t.boolean :administration_unit
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
