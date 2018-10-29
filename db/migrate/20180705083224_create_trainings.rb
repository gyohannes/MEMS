class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings do |t|
      t.references :contact, foreign_key: true
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
