class EquipmentType < ApplicationRecord

  has_many :equipment

  def to_s
    name
  end
end
