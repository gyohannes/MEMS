class ProcurementRequest < ApplicationRecord
  belongs_to :organization_structure, optional: true
  belongs_to :facility, optional: true
  belongs_to :user
  has_many :procurement_request_equipments, dependent: :destroy

  accepts_nested_attributes_for :procurement_request_equipments, allow_destroy: true

end
