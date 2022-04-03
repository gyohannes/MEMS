class CreateBackups < ActiveRecord::Migration[5.2]
  def change
    create_table :backups, id: :uuid do |t|
      t.date :backup_date

      t.timestamps
    end
  end
end
