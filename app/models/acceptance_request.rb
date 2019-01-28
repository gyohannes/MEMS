class AcceptanceRequest < ApplicationRecord
  belongs_to :organization_structure, optional: true
  belongs_to :facility, optional: true
  belongs_to :institution, optional: true
  belongs_to :user
  belongs_to :decided_user, optional: true, :class_name => 'User', :foreign_key => "decision_by"

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
