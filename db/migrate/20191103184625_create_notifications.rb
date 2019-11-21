class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.string :name
      t.references :notifiable, type: :uuid, polymorphic: true, index: true

      t.timestamps
    end
  end
end
