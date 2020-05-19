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
  has_many :documents, as: :documentable

  after_find :set_attributes

  accepts_nested_attributes_for :documents, allow_destroy: true

  validates :equipment_name_id, :model, :serial_number, :maintenance_requirement_id, presence: true

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
  scope :list_by_from, -> (from_date) { where('installation_date >= ?', from_date)}
  scope :list_by_to, -> (to_date) { where('installation_date <= ?', to_date)}
  scope :list_by_acquisition_type, -> (acquisition_type) {where(acquisition_type: acquisition_type) unless acquisition_type.blank?}

  def self.search(name=nil, org_structure=nil, type=nil, model=nil, status=nil, user=nil, inventory_number=nil, from=nil, to=nil, aq_type=nil)
    equipment = []
    available_filters = {org_structure => list_by_org_structure(org_structure), type => list_by_type(type),
                         name => list_by_name(name), model => list_by_model(model), status => list_by_status(status),
                         user => list_by_user(user), inventory_number => list_by_inventory_number(inventory_number),
                         from => list_by_from(from), to => list_by_to(to), aq_type => list_by_acquisition_type(aq_type) }.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      equipment = counter == 0 ? v : equipment.merge(v)
      counter += 1
    end
    return equipment.uniq
  end

  def disposed
    return status == Status.find_by(name: 'Disposed')
  end

  def pp_maintenances
    maintenances.where(maintenance_type: Constants::PREVENTIVE).order('end_date DESC')
  end

  def preventive_maintenance_date
    (pp_maintenances.first.try(:end_date) || installation_date) + maintenance_requirement.days rescue nil
  end

  def set_attributes
    self.location = equipment_name.name
    self.trained_end_users = !Training.joins(:contact).where('contacts.organization_unit_id = ? and training_type = ? and equipment_name_id = ? and (model = ? or model = ?)',
                                                             organization_unit_id, Constants::END_USER, equipment_name_id, "",model).blank?
    self.trained_technical_personnel = !Training.joins(:contact).where('contacts.organization_unit_id = ? and training_type = ? and equipment_name_id = ? and (model = ? or model = ?)',
                                                                       organization_unit_id, Constants::MAINTENANCE_PERSONNEL, equipment_name_id, "",model).blank?
    self.years_used = ((Date.today - (manufactured_year || Date.today))/365).floor
  end

  def trainings
    return Training.where('equipment_name_id = ? and (model = ? or model is null)', equipment_name_id, model)
  end

  def to_s
    [equipment_name, inventory_number].join(' - ')
  end
end
