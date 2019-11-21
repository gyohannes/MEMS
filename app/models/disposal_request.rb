class DisposalRequest < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :facility, optional: true
  belongs_to :equipment
  belongs_to :user
  belongs_to :decided_user, optional: true, :class_name => 'User', :foreign_key => "decision_by"

  def request_from
    if organization_unit_id?
      return organization_unit.to_s
    elsif facility_id?
      return facility.to_s
    end
  end

  def request_from_type
    if organization_unit_id?
      return organization_unit.organization_unit_type
    elsif facility_id?
      return Constants::FACILITY
    end
  end

end
