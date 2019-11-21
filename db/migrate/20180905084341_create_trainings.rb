class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings, id: :uuid do |t|
      t.references :contact, type: :uuid, foreign_key: true
      t.references :training_request, type: :uuid, foreign_key: true
      t.string :equipment_name
      t.string :model
      t.string :training_type
      t.string :trainer_name
      t.string :training_sponsor
      t.date :training_date

      t.timestamps
    end
  end
end
