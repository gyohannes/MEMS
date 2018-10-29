class EquipmentName < ApplicationRecord
  belongs_to :equipment_category

  def to_s
    name
  end
end
