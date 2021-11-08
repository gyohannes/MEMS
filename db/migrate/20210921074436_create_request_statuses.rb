class CreateRequestStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :request_statuses, id: :uuid do |t|
      t.references :procurement_request, foreign_key: true, type: :uuid
      t.references :epsa_team, foreign_key: true, type: :uuid
      t.references :epsa_status, foreign_key: true, type: :uuid
      t.date :status_date

      t.timestamps
    end
  end
end
