class User < ApplicationRecord
  belongs_to :organization_structure, optional: true
  belongs_to :institution, optional: true
  belongs_to :facility, optional: true
  belongs_to :department, optional: true
  belongs_to :store, optional: true
  has_many :maintenance_work_orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :correct_user

  def user_type
    facility  ? Constants::FACILITY : (organization_structure ? organization_structure.organization_structure_type :
                                           (institution ? institution.institution_type : ''))
  end
  def from_type
    facility ? facility.to_s : (organization_structure ? organization_structure.to_s : (institution ? institution.to_s : '' ))
  end

  def correct_user
    if !institution.blank?
      self[:organization_structure_id] = nil
      self[:facility_id] = nil
    end
    if !facility.blank?
      self[:organization_structure_id] = nil
    end
  end

  def procurement_requests
    !facility.blank? ? facility.procurement_requests : organization_structure.procurement_requests
  end

  def incoming_procurement_requests
    procurement_requests = []
    if !facility.blank?
      procurement_requests = facility.procurement_requests.where('request_to = ?', Constants::FACILITY)
    elsif !organization_structure.blank?
      procurement_requests = ProcurementRequest.where('request_to = ? and (organization_structure_id in (?) or facility_id in (?))',
                organization_structure.organization_structure_type,
                (organization_structure.sub_units.pluck(:id) << organization_structure_id), organization_structure.sub_facilities.pluck(:id))
    elsif !institution.blank?
      procurement_requests = institution.procurement_requests
    end
    return procurement_requests
  end

  def specification_requests
    !facility.blank? ? facility.specification_requests : organization_structure.specification_requests
  end

  def incoming_specification_requests
    specification_requests = []
    if !facility.blank?
      specification_requests = facility.specification_requests.where('request_to = ?', Constants::FACILITY)
    elsif !organization_structure.blank?
      specification_requests = SpecificationRequest.where('request_to = ? and (organization_structure_id in (?) or facility_id in (?))',
                organization_structure.organization_structure_type,
                (organization_structure.sub_units.pluck(:id) << organization_structure_id),organization_structure.sub_facilities.pluck(:id))
    elsif !institution.blank?
      specification_requests = institution.specification_requests
    end
    return specification_requests
  end

  def spare_part_requests
    !facility.blank? ? facility.spare_part_requests : organization_structure.spare_part_requests
  end

  def incoming_spare_part_requests
    spare_part_requests = []
    if !facility.blank?
      spare_part_requests = facility.spare_part_requests.where('request_to = ?', Constants::FACILITY)
    elsif !organization_structure.blank?
      spare_part_requests = SparePartRequest.where('request_to = ? and (organization_structure_id in (?) or facility_id in (?))',
                organization_structure.organization_structure_type,
                (organization_structure.sub_units.pluck(:id) << organization_structure_id), organization_structure.sub_facilities.pluck(:id))
    elsif !institution.blank?
      spare_part_requests = institution.spare_part_requests
    end
    return spare_part_requests
  end


  def acceptance_requests
    !facility.blank? ? facility.acceptance_requests : organization_structure.acceptance_requests
  end

  def incoming_acceptance_requests(user=nil)
    acceptance_requests = []
    if !facility.blank?
      acceptance_requests = facility.acceptance_requests.where('request_to = ?', Constants::FACILITY)
    elsif !organization_structure.blank?
      acceptance_requests = AcceptanceRequest.where('request_to = ? and (organization_structure_id in (?) or facility_id in (?))',
                organization_structure.organization_structure_type,
                (organization_structure.sub_units.pluck(:id) << organization_structure_id), organization_structure.sub_facilities.pluck(:id))
    elsif !institution.blank?
      acceptance_requests = institution.acceptance_requests
    end
    return acceptance_requests
  end

  def training_requests
    !facility.blank? ? facility.training_requests : organization_structure.training_requests
  end

  def incoming_training_requests
    training_requests = []
    if !facility.blank?
      training_requests = facility.training_requests.where('request_to = ?', Constants::FACILITY)
    elsif !organization_structure.blank?
      training_requests = TrainingRequest.where('request_to = ? and (organization_structure_id in (?) or facility_id in (?))',
                organization_structure.organization_structure_type,
                (organization_structure.sub_units.pluck(:id) << organization_structure_id),organization_structure.sub_facilities.pluck(:id))
    elsif !institution.blank?
      training_requests = institution.training_requests
    end
    return training_requests
  end

  def installation_requests
    !facility.blank? ? facility.installation_requests : organization_structure.installation_requests
  end

  def incoming_installation_requests
    installation_requests = []
    if !facility.blank?
      installation_requests = facility.installation_requests.where('request_to = ?', Constants::FACILITY)
    elsif !organization_structure.blank?
      installation_requests = InstallationRequest.where('request_to = ? and (organization_structure_id in (?) or facility_id in (?))',
                organization_structure.organization_structure_type,
                (organization_structure.sub_units.pluck(:id) << organization_structure_id), organization_structure.sub_facilities.pluck(:id))
    elsif !institution.blank?
      installation_requests = institution.installation_requests
    end
    return installation_requests
  end

  def maintenance_requests
    !facility.blank? ? facility.maintenance_requests : organization_structure.maintenance_requests
  end

  def incoming_maintenance_requests(user=nil)
    maintenance_requests = []
    if !facility.blank?
      maintenance_requests = facility.maintenance_requests.where('request_to = ?', Constants::FACILITY)
    elsif !organization_structure.blank?
      maintenance_requests = MaintenanceRequest.where('request_to = ? and (organization_structure_id in (?) or facility_id in (?))',
                                                      organization_structure.organization_structure_type, (organization_structure.sub_units.pluck(:id) << organization_structure_id),
                                                      organization_structure.sub_facilities.pluck(:id))
    elsif !institution.blank?
      maintenance_requests = institution.maintenance_requests
    end
    return maintenance_requests
  end

  def calibration_requests
    !facility.blank? ? facility.calibration_requests : organization_structure.calibration_requests
  end

  def incoming_calibration_requests(user=nil)
    calibration_requests = []
    if !facility.blank?
      calibration_requests = facility.calibration_requests.where('request_to = ?', Constants::FACILITY)
    elsif !organization_structure.blank?
      calibration_requests = CalibrationRequest.where('request_to = ? and (organization_structure_id in (?) or facility_id in (?))',
                organization_structure.organization_structure_type,
                (organization_structure.sub_units.pluck(:id) << organization_structure_id), organization_structure.sub_facilities.pluck(:id))
    elsif !institution.blank?
      calibration_requests = institution.calibration_requests
    end
    return calibration_requests
  end

  def disposal_requests
    !facility.blank? ? facility.disposal_requests : organization_structure.disposal_requests
  end

  def incoming_disposal_requests(user=nil)
    disposal_requests = []
    if !facility.blank?
      disposal_requests = facility.disposal_requests.where('request_to = ?', Constants::FACILITY)
    elsif !organization_structure.blank?
      disposal_requests = DisposalRequest.where('request_to = ? and (organization_structure_id in (?) or facility_id in (?))',
                organization_structure.organization_structure_type,
                (organization_structure.sub_units.pluck(:id) << organization_structure_id), organization_structure.sub_facilities.pluck(:id))
    end
    return disposal_requests
  end

  def budget_requests
    !facility.blank? ? facility.budget_requests : organization_structure.budget_requests
  end

  def incoming_budget_requests
    budget_requests = []
    if !facility.blank?
      budget_requests = facility.budget_requests.where('request_to = ?', Constants::FACILITY)
    elsif !organization_structure.blank?
      budget_requests = BudgetRequest.where('request_to = ? and (organization_structure_id in (?) or facility_id in (?))',
                                            organization_structure.organization_structure_type,
                                            (organization_structure.sub_units.pluck(:id) << organization_structure_id), organization_structure.sub_facilities.pluck(:id))
    end
    return budget_requests
  end

  def maintenance_toolkit_requests
    !facility.blank? ? facility.maintenance_toolkit_requests : organization_structure.maintenance_toolkit_requests
  end

  def incoming_maintenance_toolkit_requests(user=nil)
    maintenance_toolkit_requests = []
    if !facility.blank?
      maintenance_toolkit_requests = facility.maintenance_toolkit_requests.where('request_to = ?', Constants::FACILITY)
    elsif !organization_structure.blank?
      maintenance_toolkit_requests = MaintenanceToolkitRequest.where('request_to = ? and (organization_structure_id in (?) or facility_id in (?))',
                organization_structure.organization_structure_type,
                (organization_structure.sub_units.pluck(:id) << organization_structure_id), organization_structure.sub_facilities.pluck(:id))
    elsif !institution.blank?
      maintenance_toolkit_requests = institution.maintenance_toolkit_requests
    end
    return maintenance_toolkit_requests
  end


  def super_admin?
    organization_structure == OrganizationStructure.top_organization_structure
  end

  def is_role(given_role)
    given_role == role
  end

  def parent_org_unit
    super_admin? ? OrganizationStructure.top_organization_structure : organization_structure
  end

  def load_equipment
    equipment = []
    if organization_structure
      equipment = organization_structure.sub_equipment
    elsif facility and department
      equipment = department.department_equipment(facility_id)
    elsif facility
      equipment = facility.equipment
    end
    return equipment
  end

  def load_contacts
    contacts = []
    if organization_structure
      contacts = organization_structure.sub_contacts
    elsif facility
      contacts = facility.contacts
    end
    return contacts
  end

  def load_users(role)
    return facility ? facility.users.where('role = ?', role) : (institution ? institution.users.where('role = ?', role) :
                                                                    (organization_structure ? organization_structure.users.where('role = ?', role) : []))
  end

  def self.load_users(user,type)
    users = []
    if user.super_admin?
      users = User.where('user_type = ?', type)
    elsif user.institution
      users = User.where('institution_id = ?', user.institution_id)
    elsif user.facility
      users = User.where('facility_id = ?', user.facility_id)
    elsif user.organization_structure
      users = user.organization_structure.sub_users
    end
    return users
  end


  def full_name
    [first_name, father_name, grand_father_name].join(' ')
  end

  def to_s
    full_name
  end

  def name_and_from_type
    [to_s, from_type].join(' - ')
  end

end
