class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
