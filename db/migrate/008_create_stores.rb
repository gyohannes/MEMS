class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.string :store_name
      t.string :block_number
      t.string :room_number

      t.timestamps
    end
  end
end
