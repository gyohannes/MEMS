class CreateBudgetRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :budget_requests, id: :uuid do |t|
      t.references :organization_structure, type: :uuid, foreign_key: true
      t.references :facility, type: :uuid, foreign_key: true
      t.string :budget_name
      t.text :budget_description
      t.float :amount
      t.string :request_to
      t.text :contact_address
      t.string :requested_by
      t.date :request_date
      t.string :status
      t.timestamps
    end
  end
end
