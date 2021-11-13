class Forward < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :institution, optional: true
  belongs_to :forwardable, polymorphic: true

  after_create :forward_to_epsa
  after_create :notify

  def self.forwarded(object, org_unit)
    object.forwards.order('created_at DESC').first.organization_unit_id == org_unit
  end

  def forward_to_epsa
    if forwardable_type == 'ProcurementRequest' and !institution.blank?
      RequestStatus.create(procurement_request_id: forwardable_id, epsa_team_id: EpsaTeam.entry_team.try(:id))
    end
  end

  def notify
    if !organization_unit.blank? or !institution.blank?
      status = !organization_unit.blank? ? 'Forwarded' : 'Out Sourced'
      Notification.create(organization_unit_id: organization_unit_id, institution_id: institution_id,
                          name: forwardable_type.underscore.humanize << ' ' << status, notifiable_type: forwardable_type,
                                                     notifiable_id: forwardable_id)
    end
  end
end
