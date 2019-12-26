class Disposal < ApplicationRecord
  belongs_to :equipment
  has_one_attached :attachment

  scope :list_by_user, -> (user) { joins(:equipment).where('organization_unit_id in (?)', user.organization_unit.sub_units.pluck(:id) << user.organization_unit_id) unless user.blank? }
  scope :list_by_org_unit, -> (org_unit) { joins(:equipment).where('organization_unit_id in (?)', OrganizationUnit.find_by(id: org_unit).sub_units.pluck(:id) << org_unit) unless org_unit.blank? }
  scope :list_by_type, -> (type) { joins(:equipment).where('equipment_type_id = ?',type) unless type.blank? }
  scope :list_by_disposal_reasons, -> (reasons) { where('reason_for_disposal in (:term)', term: reasons) unless reasons.blank? }
  scope :list_by_disposal_methods, -> (methods) { where('disposal_method in (:term)', term: methods) unless methods.blank? }
  scope :list_by_from, -> (from_date) {where('disposed_date >= ?', from_date) unless from_date.blank?}
  scope :list_by_to, -> (to_date) {where('disposed_date <= ?', to_date) unless to_date.blank?}

  def self.search(org_unit=nil, equipment_type=nil, reasons=nil, methods=nil, user=nil, from=nil, to=nil)
    disposals = []
    available_filters = {org_unit => list_by_org_unit(org_unit), equipment_type => list_by_type(equipment_type),
                         reasons => list_by_disposal_reasons(reasons), methods => list_by_disposal_methods(methods), user => list_by_user(user),
                         from => list_by_from(from), to => list_by_to(to)}.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      disposals = counter == 0 ? v : disposals.merge(v)
      counter += 1
    end
    return disposals.uniq
  end
end
