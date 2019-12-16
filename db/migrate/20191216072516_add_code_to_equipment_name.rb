class AddCodeToEquipmentName < ActiveRecord::Migration[5.2]
  def change
    add_column :equipment_names, :code, :string
  end
end
