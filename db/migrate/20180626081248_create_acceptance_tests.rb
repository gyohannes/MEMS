class CreateAcceptanceTests < ActiveRecord::Migration[5.1]
  def change
    create_table :acceptance_tests, id: :uuid do |t|
      t.references :equipment, type: :uuid, foreign_key: true
      t.boolean :meet_standard
      t.boolean :with_order_specification
      t.boolean :installation_done
      t.boolean :test_run
      t.boolean :accepted
      t.boolean :maintenance_personnel_trained
      t.boolean :end_users_trained
      t.boolean :with_full_accessery
      t.boolean :with_manual
      t.string :status
      t.string :approved_by
      t.date :acceptance_testing_date
      t.string :contact_address
      t.text :note

      t.timestamps
    end
  end
end
