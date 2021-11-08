class CreateEquipmentIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :equipment_issues, id: :uuid do |t|
      t.references :sub_distribution, type: :uuid, foreign_key: true
      t.integer :quantity
      t.string :issued_by
      t.date :issue_date
      t.text :remark
      t.string :GRV_number
      t.string :STV_number
      t.string :model
      t.string :received_by
      t.string :receiver_contact_address
      t.boolean :status

      t.timestamps
    end
  end
end
