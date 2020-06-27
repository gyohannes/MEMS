class ModelEquipmentList < ApplicationRecord
  belongs_to :organization_unit
  has_many :model_equipments, dependent: :destroy

  accepts_nested_attributes_for :model_equipments, allow_destroy: true

end
