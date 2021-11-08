class ProcurementRequest < ApplicationRecord
  belongs_to :organization_unit
  belongs_to :specification, optional: true
  belongs_to :user
  belongs_to :institution, optional: true
  belongs_to :decided_user, optional: true, :class_name => 'User', :foreign_key => "decision_by"
  has_many :notifications, as: :notifiable
  has_many :forwards, as: :forwardable
  has_one_attached :attachment
  has_many :procurement_request_equipments, dependent: :destroy
  has_many :procurement_request_spare_parts, dependent: :destroy
  has_many :request_statuses

  accepts_nested_attributes_for :forwards, allow_destroy: true
  accepts_nested_attributes_for :procurement_request_equipments, allow_destroy: true
  accepts_nested_attributes_for :procurement_request_spare_parts, allow_destroy: true

  validates :request_date, presence: true


  def notify(og=nil, ins=nil, status=nil)
      notification = notifications.build(name: user.organization_unit.try(:to_s) << " Procurement Request #{status} ",
                                                   organization_unit_id: og.try(:id), institution_id: ins.try(:id))
      notification.save
  end

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

  def to_s
    user.organization_unit
  end

end
