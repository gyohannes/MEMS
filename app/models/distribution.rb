class Distribution < ApplicationRecord
  belongs_to :equipment_name
  belongs_to :institution
  has_many :sub_distributions, dependent: :destroy

  accepts_nested_attributes_for :sub_distributions, allow_destroy: true

  validates :request_date, presence: true

  def total_quantity(user=nil)
    sub_distributions.where('organization_unit_id in (?)', user.organization_unit.sub_units.pluck('id') << user.organization_unit_id).pluck(:quantity).sum
  end

  def sub_distrs(user)
    sub_distributions.where('organization_unit_id in (?)', user.organization_unit.sub_units.pluck('id') << user.organization_unit_id)
  end

  def to_s
    equipment_name.name
  end

end
