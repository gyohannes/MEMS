class CreateStoreRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :store_registrations, id: :uuid do |t|
      t.references :store, type: :uuid, foreign_key: true
      t.string :been_number
      t.references :equipment, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
