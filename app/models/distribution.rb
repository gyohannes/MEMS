class Distribution < ApplicationRecord
  belongs_to :equipment_name
  belongs_to :institution
  has_many :sub_distributions, dependent: :destroy

  accepts_nested_attributes_for :sub_distributions, allow_destroy: true

  validates :request_date, presence: true

  def total_quantity(user=nil)
    if user.organization_unit
      sub_distributions.where('organization_unit_id in (?)', user.organization_unit.sub_units.pluck('id') << user.organization_unit_id).pluck(:quantity).sum
    else
      sub_distributions.pluck(:quantity).sum
    end
  end

  def sub_distrs(user)
    if user.organization_unit
      sub_distributions.where('organization_unit_id in (?)', user.organization_unit.sub_units.pluck('id') << user.organization_unit_id)
    else
      sub_distributions
    end
  end

  def to_s
    equipment_name.name
  end

end
