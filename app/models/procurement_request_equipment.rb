class ProcurementRequestEquipment < ApplicationRecord
  belongs_to :procurement_request

  validates :equipment_name, :specification, :quantity, presence: true
  validate :approved_must_be_less_or_equal_requested

  def approved_must_be_less_or_equal_requested
    if !approved_quantity.blank? and approved_quantity > quantity
      errors.add(:approved_quantity, 'must be less or equal to requested quantity')
    end
  end

end
