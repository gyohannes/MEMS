class Forward < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :institution, optional: true
  belongs_to :forwardable, polymorphic: true

  after_save :forward_to_epsa

  def self.forwarded(object, org_unit)
    object.forwards.order('created_at DESC').first.organization_unit_id == org_unit
  end

  def forward_to_epsa
    if forwardable_type == 'ProcurementRequest'
      RequestStatus.create(procurement_request_id: forwardable_id, epsa_team_id: EpsaTeam.entry_team.try(:id))
    end
  end
end
