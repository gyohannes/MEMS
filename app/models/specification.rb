class Specification < ApplicationRecord
  belongs_to :equipment_name
  belongs_to :organization_unit_type
  belongs_to :department

  validates :item_detail, presence: true

  def to_s
    equipment_name
  end

end
