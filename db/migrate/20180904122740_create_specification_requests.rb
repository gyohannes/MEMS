class CreateSpecificationRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :specification_requests, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.references :facility, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.string :request_to
      t.references :institution, type: :uuid, foreign_key: true
      t.string :equipment_name
      t.float :quantity
      t.date :requested_date
      t.text :comment
      t.string :decision_by, type: :uuid
      t.string :assigned_to, type: :uuid
      t.string :status
      t.timestamps
    end
  end
end
