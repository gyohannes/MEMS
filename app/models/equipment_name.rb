class EquipmentName < ApplicationRecord
  belongs_to :equipment_type
  has_many :model_equipments
  has_many :equipment

  def to_s
    name
  end
end
