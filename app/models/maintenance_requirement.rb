class MaintenanceRequirement < ApplicationRecord

  validates :name, :days, presence: true

  def to_s
    name
  end

end
