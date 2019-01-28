class CreateOrganizationStructures < ActiveRecord::Migration[5.1]
  def change
    create_table :organization_structures, id: :uuid do |t|
      t.string :name
      t.string :code
      t.string :organization_structure_type
      t.string :parent_organization_structure_id, type: :uuid

      t.timestamps
    end
  end
end
