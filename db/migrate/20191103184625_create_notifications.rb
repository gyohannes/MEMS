class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.references :institution, type: :uuid, foreign_key: true
      t.references :department, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.string :name
      t.references :notifiable, type: :uuid, polymorphic: true, index: true

      t.timestamps
    end
  end
end
