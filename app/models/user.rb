class User < ApplicationRecord
  belongs_to :organization_structure, optional: true
  belongs_to :role, optional: true
  belongs_to :institution, optional: true
  belongs_to :facility, optional: true
  has_and_belongs_to_many :roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def super_admin?
    organization_structure == OrganizationStructure.top_organization_structure
  end

  def admin?
    roles.pluck(:name).include?('Admin') rescue nil
  end

  def parent_org_unit
    super_admin? ? OrganizationStructure.top_organization_structure : organization_structure
  end

  def load_equipment
    equipment = []
    if !organization_structure.blank?
      equipment = organization_structure.sub_equipment
    elsif !facility.blank?
      equipment = facility.equipment
    end
    return equipment
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

end
