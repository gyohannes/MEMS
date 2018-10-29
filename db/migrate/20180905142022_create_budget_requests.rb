class CreateBudgetRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :budget_requests do |t|
      t.references :organization_structure, foreign_key: true
      t.references :facility, foreign_key: true
      t.string :budget_name
      t.text :budget_description
      t.float :amount
      t.string :requested_to
      t.integer :request_to_org_structure
      t.integer :request_to_facility
      t.text :contact_address
      t.string :requested_by
      t.date :request_date

      t.timestamps
    end
  end
end
