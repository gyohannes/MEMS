class CreateReceives < ActiveRecord::Migration[5.1]
  def change
    create_table :receives do |t|
      t.references :store, foreign_key: true
      t.string :deliverer_name
      t.string :recipient_name
      t.string :witness_name
      t.date :delivery_date
      t.text :remark

      t.timestamps
    end
  end
end
