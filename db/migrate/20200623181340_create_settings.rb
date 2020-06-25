class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings, id: :uuid do |t|
      t.string :host
      t.string :server_ip
      t.string :app_email
      t.string :app_email_pass

      t.timestamps
    end
  end
end
