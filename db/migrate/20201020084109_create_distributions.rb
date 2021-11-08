class CreateDistributions < ActiveRecord::Migration[5.2]
  def change
    create_table :distributions, id: :uuid do |t|
      t.references :institution, type: :uuid, foreign_key: true
      t.references :equipment_name, type: :uuid, foreign_key: true
      t.date :request_date


      t.timestamps
    end
  end
end
