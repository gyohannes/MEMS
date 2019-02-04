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

  STATUSES = [IN_STORE = 'In Store', NEW='New', UNDER_MAINTENANCE = 'Under Maintenance', FUNCTIONAL='Functional', NOT_FUNCTIONAL='Not Functional', DISPOSED='Disposed']

  FUNCTIONAL_STATUSES = [FUNCTIONAL='Functional', NOT_FUNCTIONAL='Not Functional']
  scope :active, -> { where.not(status: self::DISPOSED)}

  scope :list_by_user, -> (user) { user.load_equipment unless user.blank? }
  scope :list_by_org_structure, -> (org_structure) { OrganizationStructure.find_by(id: org_structure).sub_equipment unless org_structure.blank? }
  scope :list_by_facility, -> (facility) { Facility.find_by(id: facility).equipment unless facility.blank? }
  scope :list_by_category, -> (category) { EquipmentCategory.find_by(id: category).equipment unless category.blank? }
  scope :list_by_name, -> (name) { where('LOWER(equipment_name) LIKE :term', term: "%#{name.downcase}%") unless name.blank? }
  scope :list_by_model, -> (model) { where('LOWER(model) LIKE :term', term: "%#{model.downcase}%") unless model.blank?}
  scope :list_by_status, -> (status) { where('status in (:term)', term: status) unless status.blank? }

  def self.search(name=nil, org_structure=nil, facility=nil, category=nil, model=nil, status=nil, user=nil)
    equipment = []
    available_filters = {org_structure => list_by_org_structure(org_structure), facility => list_by_facility(facility), category => list_by_category(category),
                         name => list_by_name(name), model => list_by_model(model), status => list_by_status(status), user => list_by_user(user) }.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      equipment = counter == 0 ? v : equipment.merge(v)
      counter += 1
    end
    return equipment.uniq
  end


  def preventive_maintenance_date
    dates = []
    dates << installation.preventive_maintenance_date unless installation.blank?
    dates << maintenances.sort_by{|x| x.end_date }.last.preventive_maintenance_date unless maintenances.blank?
    return dates.sort.last
  end
  def set_trained_end_users
    self.trained_end_users = !trainings.joins(:contact).where('contacts.facility_id = ? and training_type = ?',
                                     facility_id, Constants::END_USER).blank?
  end

  def set_trained_maintenance_personnel
    self.trained_maintenance_personnel= !trainings.joins(:contact).where('contacts.facility_id = ? and training_type = ?',
                                     facility_id, Constants::MAINTENANCE_PERSONNEL).blank?
  end

  def set_date_of_installation
   self.date_of_installation = installation.try(:date_of_installation)
  end

  def set_use_of_years
    self.use_of_years = self.use_of_years || 0 + (Date.today - (set_date_of_installation || Date.today))/365
  end

  def trainings
    return Training.where('equipment_name = ? and (model = ? or model is null)', equipment_name, model)
  end

  def to_s
    [equipment_name, serial_number].join(' - ')
  end
end
