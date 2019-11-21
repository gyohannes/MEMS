class SparePart < ApplicationRecord
  belongs_to :organization_unit
  belongs_to :equipment_name
  has_many :receive_spare_parts
  has_many :issue_spare_parts

  def available
    receive_spare_parts.pluck(:quantity).sum - issue_spare_parts.pluck(:quantity).sum
  end

  def min_re_order_level_vs_available(type)
    if type == 'Min Re-order Level'
      return min_reorder_level
    elsif type == 'Available'
      return available
    end
  end

  def to_s
    name
  end
end
