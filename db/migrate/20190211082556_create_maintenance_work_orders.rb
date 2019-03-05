class CreateMaintenanceWorkOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenance_work_orders, id: :uuid do |t|
      t.references :equipment, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.string :location
      t.date :date
      t.text :description_of_problem
      t.text :remark
      t.string :status
      t.text :note

      t.timestamps
    end
  end
end
