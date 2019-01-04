class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts, id: :uuid do |t|
      t.references :organization_structure, type: :uuid, foreign_key: true
      t.references :facility, type: :uuid, foreign_key: true
      t.string :name_of_contact
      t.string :profession
      t.string :title
      t.string :work_place
      t.string :city
      t.string :phone_number
      t.string :country
      t.string :email

      t.timestamps
    end
  end
end
