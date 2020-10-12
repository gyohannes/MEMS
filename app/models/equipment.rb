class Equipment < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :equipment_type, optional: true
  belongs_to :equipment_name
  belongs_to :department, optional: true
  belongs_to :institution, optional: true
  has_many :maintenances, dependent: :destroy
  has_one :disposal, dependent: :destroy
  has_many :inventories, dependent: :destroy
  has_many :calibration_requests, dependent: :destroy
  has_many :disposal_requests, dependent: :destroy
  has_many :maintenance_requests, dependent: :destroy
  has_many :maintenance_work_orders, dependent: :destroy
  belongs_to :maintenance_requirement
  belongs_to :status
  has_many :documents, as: :documentable, dependent: :destroy
  belongs_to :maintenance_provider, optional: true, :class_name => 'Institution', :foreign_key => "maintenance_service_provider"

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

  def country_name
    c = ISO3166::Country[country]
    c.translations[I18n.locale.to_s] || c.name rescue nil
  end

  def self.import_equipments(file, user)
    equipments = []
    CSV.foreach(file.path, :headers=>true, encoding: 'iso-8859-1:utf-8') do |row|
      inventory_number = row[0]
      equipment_type = row[1].blank? ? nil : EquipmentType.find_or_create_by(name: row[1])
      equipment_name = row[2].blank? ? nil : EquipmentName.find_or_create_by(name: row[2])
      department = row[3].blank? ? nil : Department.find_or_create_by(name: row[3])
      location = row[4]
      installation_date = row[5]
      warranty_expire_date = row[6]
      maintenance_provider = row[7].blank? ? nil : Institution.find_or_create_by(name: row[7])
      maintenance_requirement = row[8].blank? ? nil : MaintenanceRequirement.find_or_create_by(name: row[8])
      description = row[9]
      country = row[10]
      manufacturer = row[11]
      model = row[12]
      serial_number = row[13]
      tag_number = row[14]
      power_requirement = row[15]
      manufactured_year = row[16].blank? ? nil : Date.new(row[16].to_i)
      acquisition_type = row[17]
      years_used = row[18]
      supplier = row[19].blank? ? nil : Institution.find_or_create_by(name: row[19])
      purchased_year = row[20].blank? ? nil : Date.new(row[20].to_i)
      order_number = row[21]
      cost = row[22]
      estimated_life_span = row[23]
      equipment_risk_classification = row[24]
      status = row[25].blank? ? nil : Status.find_or_create_by(name: row[25])

      attrbts = {organization_unit_id: user.organization_unit_id, equipment_name_id: equipment_name.try(:id), inventory_number: inventory_number, description: description,
                 equipment_type_id: equipment_type.try(:id), department_id: department.try(:id), location: location,
                 installation_date: installation_date, warranty_expire_date: warranty_expire_date, maintenance_service_provider: maintenance_provider.try(:id),
                 acquisition_type: acquisition_type, equipment_risk_classification: equipment_risk_classification, model: model, order_number: order_number,
                 cost: cost, serial_number: serial_number, tag_number: tag_number, manufacturer: manufacturer, country: country, manufactured_year: manufactured_year,
                 purchased_year: purchased_year, power_requirement: power_requirement, maintenance_requirement_id: maintenance_requirement.try(:id),
                 estimated_life_span: estimated_life_span, years_used: years_used, institution_id: supplier.try(:id), status_id: status.try(:id)}
      equipment = Equipment.find_by(attrbts)
      if equipment.blank?
        eq = Equipment.new(attrbts)
        if eq.save
          equipments << eq unless eq.blank?
        end
      end
    end
    return equipments
  end

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

  def maintenance_provider
    Institution.find_by(id: maintenance_service_provider)
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
    self.trained_end_users = !Training.joins(:contact).where('contacts.organization_unit_id = ? and training_type = ? and equipment_name_id = ?',
                                                             organization_unit_id, Constants::END_USER, equipment_name_id).blank?
    self.trained_technical_personnel = !Training.joins(:contact).where('contacts.organization_unit_id = ? and training_type = ? and equipment_name_id = ?',
                                                                       organization_unit_id, Constants::MAINTENANCE_PERSONNEL, equipment_name_id).blank?
    self.years_used = ((Date.today - (manufactured_year || Date.today))/365).floor
  end

  def trainings
    return Training.where('equipment_name_id = ? and (model = ? or model is null)', equipment_name_id, model)
  end

  def to_s
    [equipment_name, inventory_number].join(' - ')
  end
end
