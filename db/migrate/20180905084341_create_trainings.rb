class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings, id: :uuid do |t|
      t.references :contact, type: :uuid, foreign_key: true
      t.references :training_request, type: :uuid, foreign_key: true
      t.references :equipment_name, type: :uuid, foreign_key: true
      t.string :model
      t.string :training_type
      t.string :level
      t.string :trainer_name
      t.string :training_sponsor
      t.date :training_date

      t.timestamps
    end
  end
end
