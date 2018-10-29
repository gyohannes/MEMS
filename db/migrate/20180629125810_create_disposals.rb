class CreateDisposals < ActiveRecord::Migration[5.1]
  def change
    create_table :disposals do |t|
      t.references :equipment, foreign_key: true
      t.text :problem
      t.text :action_taken
      t.text :list_of_disposing_commitee
      t.text :contact_address
      t.date :disposed_date

      t.timestamps
    end
  end
end
