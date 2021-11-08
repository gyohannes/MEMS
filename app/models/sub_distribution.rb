class SubDistribution < ApplicationRecord
  belongs_to :distribution
  belongs_to :organization_unit
  belongs_to :epsa_hub, optional: true
  has_one :equipment_issue

  validates :quantity, presence: true

  def request_status
    epsa_hub.blank? ? 'Pending' : (equipment_issue.blank? ? 'Hub Assigned' : 'Delivered')
  end

  def to_s
    distribution
  end

end
