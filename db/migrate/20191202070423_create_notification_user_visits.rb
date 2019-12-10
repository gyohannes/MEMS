class CreateNotificationUserVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_user_visits, id: :uuid do |t|
      t.references :notification, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.date :visit_date

      t.timestamps
    end
  end
end
