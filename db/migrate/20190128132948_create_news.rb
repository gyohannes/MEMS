class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.references :facility, type: :uuid, foreign_key: true
      t.references :institution, type: :uuid, foreign_key: true
      t.string :headline
      t.text :content

      t.timestamps
    end
  end
end
