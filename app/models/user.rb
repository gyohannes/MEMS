class User < ApplicationRecord
  belongs_to :organization_unit
  belongs_to :institution, optional: true
  belongs_to :department, optional: true
  belongs_to :store, optional: true
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
  validates :email, :first_name, :father_name, :grand_father_name, :role, presence: true

  def parent_unit
    if is_role(Constants::BIOMEDICAL_HEAD) and organization_unit_id != OrganizationUnit.top_organization_unit.try(:id)
      organization_unit.parent_organization_unit_id
    else
      organization_unit_id
    end
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

  def incoming_procurement_requests
    ProcurementRequest.where('organization_unit_id = ?', organization_unit_id)
  end

  def outgoing_specification_requests
    SpecificationRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_specification_requests
    SpecificationRequest.where('organization_unit_id = ?', organization_unit_id)
  end

  def outgoing_training_requests
    TrainingRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_training_requests
    TrainingRequest.where('organization_unit_id = ?', organization_unit_id)
  end

  def outgoing_installation_requests
    InstallationRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_installation_requests
    InstallationRequest.where('organization_unit_id = ?', organization_unit_id)
  end

  def outgoing_maintenance_requests
    MaintenanceRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_maintenance_requests
    MaintenanceRequest.where('organization_unit_id = ? ', organization_unit_id)
  end

  def outgoing_calibration_requests
    CalibrationRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_calibration_requests
    CalibrationRequest.where('organization_unit_id = ?', organization_unit_id)
  end

  def outgoing_disposal_requests
    DisposalRequest.where('user_id in (?)', organization_unit.users.pluck(:id))
  end

  def incoming_disposal_requests
    DisposalRequest.where('organization_unit_id = ?', organization_unit_id)
  end

  def super_admin?
    organization_unit == OrganizationUnit.top_organization_unit
  end

  def parent_org_unit
    organization_unit.parent_organization_unit
  end

  def load_equipment
    equipment = []
    if department
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
