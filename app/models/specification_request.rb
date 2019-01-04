class SpecificationRequest < ApplicationRecord
  belongs_to :organization_structure, optional: true
  belongs_to :facility, optional: true
  belongs_to :institution, optional: true

  def request_from
    if organization_structure_id?
      return organization_structure.to_s
    elsif facility_id?
      return facility.to_s
    end
  end

  def request_from_type
    if organization_structure_id?
      return organization_structure.organization_structure_type.to_s
    elsif facility_id?
      return 'Health Facility'
    end
  end

end
