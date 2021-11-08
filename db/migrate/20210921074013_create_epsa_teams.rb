class CreateEpsaTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :epsa_teams, id: :uuid do |t|
      t.references :institution, foreign_key: true, type: :uuid
      t.string :name
      t.string :previous_team_id, type: :uuid

      t.timestamps
    end
  end
end
