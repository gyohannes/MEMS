class CreateReceives < ActiveRecord::Migration[5.1]
  def change
    create_table :receives, id: :uuid do |t|
      t.references :store, type: :uuid, foreign_key: true
      t.string :reference_number
      t.string :deliverer_name
      t.string :recipient_name
      t.date :receive_date
      t.text :note

      t.timestamps
    end
  end
end
