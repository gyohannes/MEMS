class CreateInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :institutions, id: :uuid do |t|
      t.references :organization_structure, type: :uuid, foreign_key: true
      t.string :name
      t.string :category
      t.string :institution_type

      t.timestamps
    end
  end
end
