class ModelEquipment < ApplicationRecord
  belongs_to :model_equipment_list
  belongs_to :equipment_name
  belongs_to :equipment_type
end
