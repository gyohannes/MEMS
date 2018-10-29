class InstallationRequest < ApplicationRecord
  belongs_to :organization_structure
  belongs_to :facility
  belongs_to :equipment_name
end
