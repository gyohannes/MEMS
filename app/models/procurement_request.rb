class ProcurementRequest < ApplicationRecord
  belongs_to :organization_structure, optional: true
  belongs_to :facility, optional: true
  belongs_to :user
  belongs_to :institution, optional: true

  has_many :procurement_request_equipments, dependent: :destroy
  validate :procurement_request_equipments
  accepts_nested_attributes_for :procurement_request_equipments, allow_destroy: true

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
