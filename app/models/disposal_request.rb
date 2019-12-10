class DisposalRequest < ApplicationRecord
  belongs_to :organization_unit
  belongs_to :equipment
  belongs_to :user
  belongs_to :decided_user, optional: true, :class_name => 'User', :foreign_key => "decision_by"
  has_many :notifications, as: :notifiable
  has_many :forwards, as: :forwardable
  has_one_attached :attachment
  accepts_nested_attributes_for :forwards, allow_destroy: true

  def request_from
    if organization_unit_id?
      return organization_unit.to_s
    elsif facility_id?
      return facility.to_s
    end
  end

  def request_from_type
    if organization_unit_id?
      return organization_unit.organization_unit_type
    elsif facility_id?
      return Constants::FACILITY
    end
  end

end
