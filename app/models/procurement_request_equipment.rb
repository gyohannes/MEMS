class ProcurementRequestEquipment < ApplicationRecord
  belongs_to :procurement_request

  validates :equipment_name, :specification, :quantity, presence: true

end
