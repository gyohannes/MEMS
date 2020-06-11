class MaintenanceRequest < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :facility, optional: true
  belongs_to :institution, optional: true
  belongs_to :equipment
  belongs_to :user
  belongs_to :equip_status, :class_name => 'Status', :foreign_key => "equipment_status"
  belongs_to :decided_user, optional: true, :class_name => 'User', :foreign_key => "decision_by"
  belongs_to :assigned_user, optional: true, :class_name => 'User', :foreign_key => "assigned_to"
  has_many :notifications, as: :notifiable
  has_many :forwards, as: :forwardable
  has_one_attached :attachment
  accepts_nested_attributes_for :forwards, allow_destroy: true

  def request_from
    facility.to_s || organization_unit.to_s
  end

  def request_from_type
    if organization_unit_id?
      return organization_unit.organization_unit_type
    elsif facility_id?
      return Constants::FACILITY
    end
  end

  def to_s
    [request_from, equipment.to_s].join(' - ')
  end

end
