class CreateProcurementRequestSpareParts < ActiveRecord::Migration[5.2]
  def change
    create_table :procurement_request_spare_parts, id: :uuid do |t|
      t.references :procurement_request, type: :uuid, foreign_key: true
      t.references :spare_part, type: :uuid, foreign_key: true
      t.integer :requested_quantity
      t.integer :approved_quantity

      t.timestamps
    end
  end
end
