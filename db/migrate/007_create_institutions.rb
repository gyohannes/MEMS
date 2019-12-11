class CreateInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :institutions, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.string :name
      t.string :category
      t.string :institution_type
      t.string :contact_person
      t.string :contact_phone
      t.string :contact_email
      t.text :address

      t.timestamps
    end
  end
end
