class Specification < ApplicationRecord
  belongs_to :equipment_name
  belongs_to :organization_unit, optional: true
  belongs_to :facility, optional: true

  has_one_attached :attachment

  validates :name, :equipment_name_id, :specification_by, :description, :contact_address, :specification_date, presence: true

  def to_s
    name
  end

end
