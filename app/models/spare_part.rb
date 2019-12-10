class SparePart < ApplicationRecord
  belongs_to :organization_unit
  belongs_to :equipment_name
  has_many :receive_spare_parts
  has_many :issue_spare_parts

  scope :list_by_user, -> (user) { where('organization_unit_id in (?)', user.organization_unit.sub_units.pluck(:id) << user.organization_unit_id) unless user.blank? }
  scope :list_by_org_unit, -> (org_unit) { where('organization_unit_id in (?)', OrganizationUnit.find_by(id: org_unit).sub_units.pluck(:id) << org_unit) unless org_unit.blank? }
  scope :list_by_name, -> (name) { where('equipment_name_id = ?',name) unless name.blank? }
  scope :list_by_spare_part_name, -> (spare_name) { where('id = ?', spare_name) unless spare_name.blank? }
  scope :list_by_from, -> (from_date) {joins(:receive_spare_parts).where('expiry_date >= ?', from_date) unless from_date.blank?}
  scope :list_by_to, -> (to_date) {joins(:receive_spare_parts).where('expiry_date <= ?', to_date) unless to_date.blank?}


  def self.search(org_unit=nil, name=nil, spare_name=nil, user=nil, from=nil, to=nil)
    spare_parts = []
    available_filters = {org_unit => list_by_org_unit(org_unit), name => list_by_name(name),
                         spare_name => list_by_spare_part_name(spare_name), user => list_by_user(user),
                         from => list_by_from(from), to => list_by_to(to)}.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      spare_parts = counter == 0 ? v : spare_parts.merge(v)
      counter += 1
    end
    return spare_parts.uniq
  end

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
