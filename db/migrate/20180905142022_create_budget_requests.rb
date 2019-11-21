class CreateBudgetRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :budget_requests, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.references :facility, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.string :budget_name
      t.text :budget_description
      t.float :amount
      t.string :request_to
      t.text :contact_address
      t.date :request_date
      t.text :comment
      t.string :decision_by, type: :uuid
      t.string :assigned_to, type: :uuid
      t.string :status
      t.timestamps
    end
  end
end
