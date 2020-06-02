class Forward < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :institution, optional: true
  belongs_to :forwardable, polymorphic: true

  def self.forwarded(object, org_unit)
    object.forwards.order('created_at DESC').first.organization_unit_id == org_unit
  end
end
