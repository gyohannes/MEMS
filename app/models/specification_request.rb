class SpecificationRequest < ApplicationRecord
  belongs_to :organization_structure, optional: true
  belongs_to :facility, optional: true
  belongs_to :equipment_name
end
