class CreateEpsaHubs < ActiveRecord::Migration[5.2]
  def change
    create_table :epsa_hubs, id: :uuid do |t|
      t.references :institution, type: :uuid, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
