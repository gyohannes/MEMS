class AddHubToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :epsa_hub_id, :string
  end
end
