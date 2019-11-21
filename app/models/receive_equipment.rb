class ReceiveEquipment < ApplicationRecord
  belongs_to :receive

  validates :equipment_name, :model, :quantity, :unit_cost, presence: true
end
