class CreateDistributions < ActiveRecord::Migration[5.2]
  def change
    create_table :distributions, id: :uuid do |t|
      t.references :equipment_name, type: :uuid, foreign_key: true
      t.date :distribution_date

      t.timestamps
    end
  end
end
