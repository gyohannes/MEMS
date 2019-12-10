class Maintenance < ApplicationRecord
  belongs_to :equipment
  belongs_to :maintenance_request, optional: true
  belongs_to :maintenance_work_order, optional: true
  belongs_to :status

  scope :list_by_user, -> (user) { joins(:equipment).where('organization_unit_id in (?)', user.organization_unit.sub_units.pluck(:id) << user.organization_unit_id) unless user.blank? }
  scope :list_by_org_unit, -> (org_unit) { joins(:equipment).where('organization_unit_id in (?)', OrganizationUnit.find_by(id: org_unit).sub_units.pluck(:id) << org_unit) unless org_unit.blank? }
  scope :list_by_name, -> (name) { joins(:equipment).where('equipment_name_id = ?',name) unless name.blank? }
  scope :list_by_model, -> (model) { joins(:equipment).where('LOWER(model) LIKE :term', term: "%#{model.downcase}%") unless model.blank?}
  scope :list_by_maintenance_type, -> (types) { where('maintenance_type in (:term)', term: types) unless types.blank? }
  scope :list_by_from, -> (from_date) {where('end_date >= ?', from_date) unless from_date.blank?}
  scope :list_by_to, -> (to_date) {where('end_date <= ?', to_date) unless to_date.blank?}


  def self.search(org_unit=nil, name=nil, model=nil, types=nil, user=nil, from=nil, to=nil)
    maintenances = []
    available_filters = {org_unit => list_by_org_unit(org_unit), name => list_by_name(name),
                         model => list_by_model(model), types => list_by_maintenance_type(types), user => list_by_user(user),
                         from => list_by_from(from), to => list_by_to(to)}.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      maintenances = counter == 0 ? v : maintenances.merge(v)
      counter += 1
    end
    return maintenances.uniq
  end

end
