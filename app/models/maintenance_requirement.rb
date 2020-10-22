class MaintenanceRequirement < ApplicationRecord

  validates :name, presence: true

  before_save :set_name

  def set_name
    self[:name] = name.titlecase  unless name.blank?
  end

  def to_s
    name
  end

end
