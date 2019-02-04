class MaintenanceRequest < ApplicationRecord
  belongs_to :organization_structure, optional: true
  belongs_to :facility, optional: true
  belongs_to :institution, optional: true
  belongs_to :equipment
  belongs_to :user
  belongs_to :decided_user, optional: true, :class_name => 'User', :foreign_key => "decision_by"
  belongs_to :assigned_user, optional: true, :class_name => 'User', :foreign_key => "assigned_to"

  def request_from
    facility.to_s || organization_structure.to_s
  end

  def request_from_type
    if organization_structure_id?
      return organization_structure.organization_structure_type
    elsif facility_id?
      return Constants::FACILITY
    end
  end

  def to_s
    [request_from, equipment.to_s].joins(' - ')
  end

end
