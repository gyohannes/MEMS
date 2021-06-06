class Training < ApplicationRecord
  belongs_to :contact
  belongs_to :equipment_name

  accepts_nested_attributes_for :contact, allow_destroy: true

  scope :list_by_user, -> (user) { where('contact_id in (?)', user.organization_unit.all_contacts) unless user.blank? }
  scope :list_by_org_structure, -> (org_structure) { where('contact_id in (?)', OrganizationUnit.find_by(id: org_structure).sub_contacts.pluck(:id)) unless org_structure.blank? }
  scope :list_by_type, -> (type) { joins(:equipment).where('equipment_type_id = ?', type) unless type.blank? }
  scope :list_by_name, -> (name) { where('equipment_name_id = ?',name) unless name.blank? }
  scope :list_by_model, -> (model) { where('LOWER(model) LIKE :term', term: "%#{model.downcase}%") unless model.blank?}
  scope :list_by_training_type, -> (types) { where('training_type in (:term)', term: types) unless types.blank? }
  scope :list_by_level, -> (levels) { where('level in (:term)', term: levels) unless levels.blank? }
  scope :list_by_from, -> (from_date) {where('training_date >= ?', from_date) unless from_date.blank?}
  scope :list_by_to, -> (to_date) {where('training_date <= ?', to_date) unless to_date.blank?}

  def self.search(org_structure=nil, name=nil, type=nil, model=nil, types=nil, levels=nil, user=nil, from=nil, to=nil)
    equipment = []
    available_filters = {org_structure => list_by_org_structure(org_structure), name => list_by_name(name),
                         type => list_by_type(type), model => list_by_model(model), types => list_by_training_type(types),
                         levels => list_by_level(levels), user => list_by_user(user),
                         from => list_by_from(from), to => list_by_to(to)}.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      equipment = counter == 0 ? v : equipment.merge(v)
      counter += 1
    end
    return equipment.uniq
  end

end
