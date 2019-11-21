class Training < ApplicationRecord
  belongs_to :contact

  accepts_nested_attributes_for :contact, allow_destroy: true

  scope :list_by_org_structure, -> (org_structure) { where('contact_id in (?)', OrganizationUnit.find_by(id: org_structure).sub_contacts.pluck(:id)) unless org_structure.blank? }
  scope :list_by_type, -> (type) { where('equipment_name in (?)', EquipmentType.find(type).equipment.pluck(:equipment_name)) unless type.blank? }
  scope :list_by_name, -> (name) { where('LOWER(equipment_name) LIKE :term', term: "%#{name.downcase}%") unless name.blank? }
  scope :list_by_model, -> (model) { where('LOWER(model) LIKE :term', term: "%#{model.downcase}%") unless model.blank?}
  scope :list_by_training_type, -> (types) { where('training_type in (:term)', term: types) unless types.blank? }

  def self.search(name=nil, org_structure=nil, type=nil, model=nil, types=nil)
    equipment = []
    available_filters = {org_structure => list_by_org_structure(org_structure), type => list_by_type(type),
                         name => list_by_name(name), model => list_by_model(model), types => list_by_training_type(types) }.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      equipment = counter == 0 ? v : equipment.merge(v)
      counter += 1
    end
    return equipment.uniq
  end

end
