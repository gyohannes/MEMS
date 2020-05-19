class MaintenanceRequirement < ApplicationRecord

  validates :name, :days, presence: true

end
