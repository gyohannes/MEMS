class ReceiveEquipment < ApplicationRecord
  belongs_to :receive
  belongs_to :equipment_name
  validates :equipment_name_id, :model, :quantity, :unit_cost, presence: true
end
