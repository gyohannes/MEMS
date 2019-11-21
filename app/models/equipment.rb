class Equipment < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :equipment_type, optional: true
  belongs_to :equipment_name
  belongs_to :department, optional: true
  belongs_to :institution
  has_one :installation
  has_one :acceptance_test
  has_many :maintenances
  has_many :planned_preventive_maintenaces
  has_one :disposal
  has_many :inventories
  belongs_to :maintenance_requirement
  belongs_to :status

  after_find :set_use_of_years
  after_find :set_trained_end_users
  after_find :set_trained_maintenance_personnel

  validates :equipment_name_id, :model, :serial_number, :tag_number, :maintenance_requirement_id, presence: true

  STATUSES = [IN_STORE = 'In Store', UNDER_MAINTENANCE = 'Under Maintenance', FUNCTIONAL='Functional', NON_FUNCTIONAL='Non Functional',PARTIALLY_FUNCTIONAL='Partially Functional',
              NON_FUNCTIONAL_REPAIRABLE = 'Non Functional repairable', NON_FUNCTIONAL_NOT_REPAIRABLE = 'Non Functional not repairable', DISPOSED='Disposed']

  FUNCTIONAL_STATUSES = [NOT_ACCEPTED='Not Accepted', FUNCTIONAL='Functional', NON_FUNCTIONAL='Non Functional',
                         NON_FUNCTIONAL_REPAIRABLE = 'Non Functional repairable', NON_FUNCTIONAL_NOT_REPAIRABLE = 'Non Functional not repairable']

  scope :active, -> { where.not(status: self::DISPOSED)}

  scope :list_by_user, -> (user) { user.load_equipment unless user.blank? }
  scope :list_by_org_structure, -> (org_structure) { OrganizationUnit.find_by(id: org_structure).sub_equipment unless org_structure.blank? }
  scope :list_by_type, -> (type) { EquipmentType.find_by(id: type).equipment unless type.blank? }
  scope :list_by_name, -> (name) { where('equipment_name_id = ?', name) unless name.blank? }
  scope :list_by_model, -> (model) { where('LOWER(model) LIKE :term', term: "%#{model.downcase}%") unless model.blank?}
  scope :list_by_status, -> (status) { where('status_id in (:term)', term: status) unless status.blank? }
  scope :list_by_inventory_number, -> (inventory_number) { joins(:equipment_name).where('LOWER(inventory_number) LIKE :term', term: "%#{inventory_number.downcase}%").select('equipment.*') unless inventory_number.blank?}

  def self.search(name=nil, org_structure=nil, type=nil, model=nil, status=nil, user=nil, inventory_number=nil)
    equipment = []
    available_filters = {org_structure => list_by_org_structure(org_structure), type => list_by_type(type),
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
    (planned_preventive_maintenaces.order('maintained_date DESC').first.try(:maintained_date) || installation_date) + maintenance_requirement.days
  end
  def set_trained_end_users
    self.trained_end_users = !Training.joins(:contact).where('contacts.facility_id = ? and training_type = ? and equipment_name = ? and (model = ? or model = ?)',
                                     organization_unit_id, Constants::END_USER, equipment_name, "",model).blank?
  end

  def set_trained_maintenance_personnel
    self.trained_technical_personnel = !Training.joins(:contact).where('contacts.facility_id = ? and training_type = ? and equipment_name = ? and (model = ? or model = ?)',
                                                                       organization_unit_id, Constants::MAINTENANCE_PERSONNEL, equipment_name, "",model).blank?
  end

  def set_use_of_years
    self.years_used = ((Date.today - (manufactured_year || Date.today))/365).floor
  end

  def trainings
    return Training.where('equipment_name = ? and (model = ? or model is null)', equipment_name, model)
  end

  def to_s
    [equipment_name, inventory_number].join(' - ')
  end
end
