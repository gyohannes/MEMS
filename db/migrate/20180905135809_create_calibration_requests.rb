class CreateCalibrationRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :calibration_requests, id: :uuid do |t|
      t.references :organization_structure, type: :uuid, foreign_key: true
      t.references :facility, type: :uuid, foreign_key: true
      t.references :equipment, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.text :calibration_description
      t.string :request_to
      t.references :institution, type: :uuid, foreign_key: true
      t.date :request_date
      t.string :status
      t.timestamps
    end
  end
end
