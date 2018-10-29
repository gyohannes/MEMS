class CreateOrganizationStructures < ActiveRecord::Migration[5.1]
  def change
    create_table :organization_structures do |t|
      t.string :name
      t.string :code
      t.references :organization_structure_type, foreign_key: true
      t.integer :parent_organization_structure_id

      t.timestamps
    end
  end
end
