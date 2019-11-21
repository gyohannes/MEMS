class MaintenanceWorkOrder < ApplicationRecord
  belongs_to :equipment
  belongs_to :maintenance_request
  belongs_to :user

  def not_completed
    status != Constants::COMPLETED
  end
end
