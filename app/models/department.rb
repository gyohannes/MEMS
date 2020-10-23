class Department < ApplicationRecord
  belongs_to :organization_unit, optional: true
  has_many :notifications
  has_many :equipment

  validates :name, presence: true

  def total_by_status(og, status)
    equipment.where(status_id: status, organization_unit_id: og).count
  end

  def to_s
    name
  end

end