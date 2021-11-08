class User < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :institution, optional: true
  belongs_to :department, optional: true
  belongs_to :store, optional: true
  belongs_to :epsa_hub, optional: true
  has_many :maintenance_work_orders, dependent: :destroy
  has_many :maintenance_requests, dependent: :destroy
  has_many :training_requests, dependent: :destroy
  has_many :procurement_requests, dependent: :destroy
  has_many :disposal_requests, dependent: :destroy
  has_many :specification_requests, dependent: :destroy
  has_many :calibration_requests, dependent: :destroy
  has_many :installation_requests, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :notification_user_visits, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :department_id, presence: true, if: :department_user
  validates :institution_id, presence: true, if: :supplier_user
  validates :organization_unit_id, presence: true, if: :org_unit_user
  validates :email, :first_name, :father_name, :grand_father_name, :role, presence: true

  def parent_unit
    if is_role(Constants::BIOMEDICAL_HEAD) and organization_unit_id != OrganizationUnit.top_organization_unit.try(:id)
      organization_unit.parent_organization_unit_id
    else
      organization_unit_id
    end
  end

  def supplier_user
    role == Constants::SUPPLIER
  end

  def org_unit_user
    [Constants::BIOMEDICAL_HEAD, Constants::BIOMEDICAL_ENGINEER].include?(role)
  end

  def department_user
    role == Constants::DEPARTMENT
  end

  def is_role(given_role)
    role == given_role
  end

  def user_type
    institution ? Constants::SUPPLIER : (organization_unit.facility==true ? Constants::FACILITY : 'Org Unit')
  end

  def from_type
    organization_unit ? organization_unit.to_s : (institution ? institution.to_s : '' )
  end

  def correct_user
    if !institution.blank?
      self[:organization_unit_id] = nil
    end
  end

  def outgoing_procurement_requests
    ProcurementRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def epsa_request_statuses
    RequestStatus.joins(:procurement_request).where('organization_unit_id in (?)',
                                                    organization_unit.sub_units.pluck(:id) << organization_unit_id)
  end
  def incoming_procurement_requests(status=Constants::PENDING)
    ProcurementRequest.where('organization_unit_id = ? and status = ?', organization_unit_id, status)
  end

  def outgoing_specification_requests
    SpecificationRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_specification_requests(status=Constants::PENDING)
    SpecificationRequest.where('organization_unit_id = ? and status = ?', organization_unit_id, status)
  end

  def outgoing_training_requests
    TrainingRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_training_requests(status=Constants::PENDING)
    TrainingRequest.where('organization_unit_id = ? and status = ?', organization_unit_id, status)
  end

  def outgoing_installation_requests
    InstallationRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_installation_requests(status=Constants::PENDING)
    InstallationRequest.where('organization_unit_id = ? and status = ?', organization_unit_id, status)
  end

  def outgoing_maintenance_requests
    MaintenanceRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_maintenance_requests(status=Constants::PENDING)
    MaintenanceRequest.where('organization_unit_id = ? and status = ?', organization_unit_id, status)
  end

  def outgoing_calibration_requests
    CalibrationRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_calibration_requests(status=Constants::PENDING)
    CalibrationRequest.where('organization_unit_id = ? and status = ?', organization_unit_id, status)
  end

  def outgoing_disposal_requests
    DisposalRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_disposal_requests(status=Constants::PENDING)
    DisposalRequest.where('organization_unit_id = ? and status = ?', organization_unit_id, status)
  end

  def super_admin?
    organization_unit == OrganizationUnit.top_organization_unit
  end

  def parent_org_unit
    organization_unit.parent_organization_unit rescue nil
  end

  def load_equipment
    equipment = []
    if is_role(Constants::DEPARTMENT) and !department.blank?
      equipment = department.equipment.where('organization_unit_id = ?', organization_unit_id)
    elsif organization_unit
      equipment = organization_unit.sub_equipment
    end
    return equipment
  end

  def load_contacts
    organization_unit.sub_contacts
  end

  def load_users(role)
    return (institution ? institution.users.where('role = ?', role) : (organization_unit ? organization_unit.users.where('role = ?', role) : []))
  end

  def self.load_users(user,type)
    users = []
    if user.super_admin?
      users = User.where('user_type = ?', type)
    elsif user.institution
      users = User.where('institution_id = ?', user.institution_id)
    elsif user.organization_unit
      users = user.organization_unit.sub_users
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
