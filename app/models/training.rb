class Training < ApplicationRecord
  belongs_to :contact

  accepts_nested_attributes_for :contact, allow_destroy: true

  scope :list_by_org_structure, -> (org_structure) { where('contact_id in (?)', OrganizationStructure.find_by(id: org_structure).sub_contacts.pluck(:id)) unless org_structure.blank? }
  scope :list_by_facility, -> (facility) { joins(:contact).where('facility_id = ?', facility) unless facility.blank? }
  scope :list_by_category, -> (category) { where('equipment_name in (?)', EquipmentCategory.find(category).equipment.pluck(:equipment_name)) unless category.blank? }
  scope :list_by_name, -> (name) { where('LOWER(equipment_name) LIKE :term', term: "%#{name.downcase}%") unless name.blank? }
  scope :list_by_model, -> (model) { where('LOWER(model) LIKE :term', term: "%#{model.downcase}%") unless model.blank?}
  scope :list_by_type, -> (types) { where('training_type in (:term)', term: types) unless types.blank? }

  def self.search(name=nil, org_structure=nil, facility=nil, category=nil, model=nil, types=nil)
    equipment = []
    available_filters = {org_structure => list_by_org_structure(org_structure), facility => list_by_facility(facility), category => list_by_category(category),
                         name => list_by_name(name), model => list_by_model(model), types => list_by_type(types) }.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      equipment = counter == 0 ? v : equipment.merge(v)
      counter += 1
    end
    return equipment.uniq
  end

end
