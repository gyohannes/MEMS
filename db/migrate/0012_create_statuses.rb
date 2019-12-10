class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses, id: :uuid do |t|
      t.string :name
      t.boolean :static
      t.text :description
      t.string :color

      t.timestamps
    end
  end
end
