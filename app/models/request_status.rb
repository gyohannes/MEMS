class RequestStatus < ApplicationRecord
  belongs_to :procurement_request
  belongs_to :epsa_team
  belongs_to :epsa_status, optional: true

  def status
    epsa_status.blank? ? 'Pending' : epsa_status.name
  end

  def to_s
    procurement_request
  end

end
