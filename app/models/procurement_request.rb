class ProcurementRequest < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :facility, optional: true
  belongs_to :user
  belongs_to :institution, optional: true
  belongs_to :decided_user, optional: true, :class_name => 'User', :foreign_key => "decision_by"
  has_many :notifications, as: :notifiable

  has_many :procurement_request_equipments, dependent: :destroy
  validate :procurement_request_equipments
  accepts_nested_attributes_for :procurement_request_equipments, allow_destroy: true

  def request_from
    if organization_unit_id?
      return organization_unit.to_s
    elsif facility_id?
      return facility.to_s
    end
  end

  def request_from_type
    if organization_unit_id?
      return organization_unit.organization_unit_type.to_s
    elsif facility_id?
      return 'Health Facility'
    end
  end

end
