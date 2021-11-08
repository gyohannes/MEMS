class CreateEpsaStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :epsa_statuses, id: :uuid do |t|
      t.string :name
      t.references :epsa_team, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
