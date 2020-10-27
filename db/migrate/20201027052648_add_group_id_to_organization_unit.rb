class AddGroupIdToOrganizationUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :organization_units, :group_id, :string
  end
end
