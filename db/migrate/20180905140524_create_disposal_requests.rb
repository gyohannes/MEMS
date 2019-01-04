class CreateDisposalRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :disposal_requests, id: :uuid do |t|
      t.references :organization_structure, type: :uuid, foreign_key: true
      t.references :facility, type: :uuid, foreign_key: true
      t.references :equipment, type: :uuid, foreign_key: true
      t.text :disposal_description
      t.string :request_to
      t.text :contact_address
      t.string :requested_by
      t.date :request_date
      t.string :status
      t.timestamps
    end
  end
end
