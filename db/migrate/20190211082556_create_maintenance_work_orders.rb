class CreateMaintenanceWorkOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenance_work_orders, id: :uuid do |t|
      t.string :work_order_number
      t.references :maintenance_request, type: :uuid, foreign_key: true
      t.references :equipment, type: :uuid, foreign_key: true
      t.string :priority
      t.references :user, type: :uuid, foreign_key: true
      t.string :status
      t.text :note

      t.timestamps
    end
  end
end
