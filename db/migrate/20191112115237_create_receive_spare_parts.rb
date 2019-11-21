class CreateReceiveSpareParts < ActiveRecord::Migration[5.2]
  def change
    create_table :receive_spare_parts, id: :uuid do |t|
      t.references :receive, type: :uuid, foreign_key: true
      t.references :spare_part, type: :uuid, foreign_key: true
      t.integer :quantity
      t.float :unit_price
      t.date :expiry_date
      t.text :remarks

      t.timestamps
    end
  end
end
