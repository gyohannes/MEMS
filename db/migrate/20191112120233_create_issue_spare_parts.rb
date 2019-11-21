class CreateIssueSpareParts < ActiveRecord::Migration[5.2]
  def change
    create_table :issue_spare_parts, id: :uuid do |t|
      t.references :issue, type: :uuid, foreign_key: true
      t.references :spare_part, type: :uuid, foreign_key: true
      t.integer :quantity
      t.text :remarks

      t.timestamps
    end
  end
end
