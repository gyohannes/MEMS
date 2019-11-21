class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories, id: :uuid do |t|
      t.references :equipment, type: :uuid, foreign_key: true
      t.references :status, type: :uuid, foreign_key: true
      t.text :description_of_problem
      t.boolean :trained_end_users
      t.boolean :trained_maintenance_personnel
      t.text :suggestion
      t.date :inventory_date
      t.string :inventory_done_by
      t.text :contact_address
      t.text :note

      t.timestamps
    end
  end
end
