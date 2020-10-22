class Department < ApplicationRecord
  belongs_to :organization_unit, optional: true
  has_many :notifications
  has_many :equipment

  validates :name, presence: true

  before_save :set_name

  def set_name
    self[:name] = name.titlecase  unless name.blank?
  end

  def total_by_status(og, status)
    equipment.where(status_id: status, organization_unit_id: og).count
  end

  def to_s
    name
  end

end