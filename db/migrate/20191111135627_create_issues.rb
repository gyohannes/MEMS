class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues, id: :uuid do |t|
      t.references :store, type: :uuid, foreign_key: true
      t.string :reference_number
      t.date :issue_date
      t.string :issued_by
      t.string :received_by

      t.timestamps
    end
  end
end
