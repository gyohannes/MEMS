class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.references :organization_structure, foreign_key: true
      t.references :facility, foreign_key: true
      t.string :store_name
      t.string :block_number
      t.string :room_number

      t.timestamps
    end
  end
end
