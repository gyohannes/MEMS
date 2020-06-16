class MaintenanceRequirement < ApplicationRecord

  validates :name, presence: true

  def to_s
    name
  end

end
