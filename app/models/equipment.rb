class Equipment < ApplicationRecord
  belongs_to :facility, optional: true
  belongs_to :equipment_category, optional: true
  belongs_to :supplier, optional: true, :class_name => 'Institution', :foreign_key => "supplier_id"
  belongs_to :local_representative, optional: true, :class_name => 'Institution', :foreign_key => "local_representative_id"
  has_one :installation
  has_one :acceptance_test
  has_many :maintenances
  has_one :disposal
  has_many :inventories

  after_find :set_use_of_years
  after_find :set_date_of_installation
  after_find :set_trained_end_users
  after_find :set_trained_maintenance_personnel

  validates :equipment_name, :model, :serial_number, :tag_number, presence: true

  STATUSES = [IN_STORE = 'In Store', UNDER_MAINTENANCE = 'Under Maintenance', FUNCTIONAL='Functional', NON_FUNCTIONAL='Non Functional',
              NON_FUNCTIONAL_REPAIRABLE = 'Non Functional repairable', NON_FUNCTIONAL_NOT_REPAIRABLE = 'Non Functional not repairable', DISPOSED='Disposed']

  FUNCTIONAL_STATUSES = [NOT_ACCEPTED='Not Accepted', FUNCTIONAL='Functional', NON_FUNCTIONAL='Non Functional',
                         NON_FUNCTIONAL_REPAIRABLE = 'Non Functional repairable', NON_FUNCTIONAL_NOT_REPAIRABLE = 'Non Functional not repairable']

  scope :active, -> { where.not(status: self::DISPOSED)}

  scope :list_by_user, -> (user) { user.load_equipment unless user.blank? }
  scope :list_by_org_structure, -> (org_structure) { OrganizationStructure.find_by(id: org_structure).sub_equipment unless org_structure.blank? }
  scope :list_by_facility, -> (facility) { Facility.find_by(id: facility).equipment unless facility.blank? }
  scope :list_by_category, -> (category) { EquipmentCategory.find_by(id: category).equipment unless category.blank? }
  scope :list_by_name, -> (name) { where('LOWER(equipment_name) LIKE :term', term: "%#{name.downcase}%") unless name.blank? }
  scope :list_by_model, -> (model) { where('LOWER(model) LIKE :term', term: "%#{model.downcase}%") unless model.blank?}
  scope :list_by_status, -> (status) { where('status in (:term)', term: status) unless status.blank? }
  scope :list_by_inventory_number, -> (inventory_number) { where('LOWER(inventory_number) LIKE :term', term: "%#{inventory_number.downcase}%") unless inventory_number.blank?}

  def self.search(name=nil, org_structure=nil, facility=nil, category=nil, model=nil, status=nil, user=nil, inventory_number=nil)
    equipment = []
    available_filters = {org_structure => list_by_org_structure(org_structure), facility => list_by_facility(facility), category => list_by_category(category),
                         name => list_by_name(name), model => list_by_model(model), status => list_by_status(status),
                         user => list_by_user(user), inventory_number => list_by_inventory_number(inventory_number) }.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      equipment = counter == 0 ? v : equipment.merge(v)
      counter += 1
    end
    return equipment.uniq
  end


  def preventive_maintenance_date
    maintenances.order('end_date DESC').first.try(:preventive_maintenance_date) || installation.try(:preventive_maintenance_date)
  end
  def set_trained_end_users
    self.trained_end_users = !Training.joins(:contact).where('contacts.facility_id = ? and training_type = ? and equipment_name = ? and (model = ? or model = ?)',
                                     facility_id, Constants::END_USER, equipment_name, "",model).blank?
  end

  def set_trained_maintenance_personnel
    self.trained_maintenance_personnel = !Training.joins(:contact).where('contacts.facility_id = ? and training_type = ? and equipment_name = ? and (model = ? or model = ?)',
                                    facility_id, Constants::MAINTENANCE_PERSONNEL, equipment_name, "",model).blank?
  end

  def set_date_of_installation
   self.date_of_installation = installation.try(:date_of_installation)
  end

  def set_use_of_years
    self.use_of_years = ((Date.today - (manufactured_year || Date.today))/365).floor
  end

  def trainings
    return Training.where('equipment_name = ? and (model = ? or model is null)', equipment_name, model)
  end

  def to_s
    [equipment_name, inventory_number].join(' - ')
  end
end
