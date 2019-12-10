class OrganizationUnit < ApplicationRecord
  belongs_to :organization_unit_type
  belongs_to :parent_organization_unit, optional: true, :class_name => 'OrganizationUnit', :foreign_key => "parent_organization_unit_id"
  has_many :sub_organization_units, :class_name => 'OrganizationUnit', :foreign_key => "parent_organization_unit_id"
  has_many :users
  has_many :stores
  has_many :store_registrations, through: :stores
  has_many :receive, through: :stores
  has_many :facilities
  has_many :institutions
  has_many :contacts
  has_many :equipment, through: :facilities
  has_many :procurement_requests
  has_many :specification_requests
  has_many :spare_part_requests
  has_many :acceptance_requests
  has_many :training_requests
  has_many :installation_requests
  has_many :maintenance_requests
  has_many :calibration_requests
  has_many :disposal_requests
  has_many :budget_requests
  has_many :maintenance_toolkit_requests
  has_many :departments
  has_many :equipment
  has_one :model_equipment_list
  has_many :model_equipments, through: :model_equipment_list
  has_many :notifications
  has_many :spare_parts
  has_many :inventories, through: :equipment
  validates :name, :code, :organization_unit_type, presence: true

  IDEAL_VS_AVAILABLE = [IDEAL='Ideal', AVAILABLE='Available']

  def ideal_vs_available(equipment_name,status)
    if status == IDEAL
      return ModelEquipment.joins(:model_equipment_list).where('equipment_name_id = ? and model_equipment_list.organization_unit_id in (?)',
                                                      equipment_name, (sub_units.pluck(:id) << id)).sum(:quantity)
    else
      return sub_equipment.where(equipment_name_id: equipment_name).select{|x| !x.disposed}.count
    end
  end

  def top_organization_unit_exists?
    !OrganizationUnit.top_organization_unit.blank?
  end

  def self.top_organization_unit
    where('parent_organization_unit_id is null').first
  end

  def self.facilities_tree
    parent = OrganizationUnit.top_organization_unit
    [parent.facility_children]
  end

  def self.full_organization_tree
    org_unit = top_organization_unit
    [org_unit.org_children] unless org_unit.blank?
  end

  def self.organization_tree(user=nil)
    org_unit = !user.department.blank? ? nil : user.try(:organization_unit)
    [org_unit.org_children] unless org_unit.blank?
  end

  def org_children
    {
        text: name,
        type: 'org unit',
        id: id,
        nodes: sub_organization_units.blank? ? nil
                   : sub_organization_units.collect{|x| x.org_children }
    }
  end

  def facility_children
    fnodes = facility_nodes
    {
        text: name << " <i>[#{organization_unit_type}]</i> ",
        type: 'org unit',
        id: id,
        nodes: fnodes.blank? ? sub_organization_units.collect{|x| x.facility_children }
                   : fnodes.map { |fn| sub_organization_units.collect{|x| x.facility_children } << fn}.flatten
    }
  end

  def facility_nodes
    nodes = []
    facilities.each do |f|
   node = {
        text: f.name << " <i>[#{f.facility_type}]</i>",
        type: 'facility',
        id: f.id,
        nodes: nil
    }
      nodes << node
    end
    return nodes
  end

  def sub_units
    sub_organization_units + sub_organization_units.collect{|x| x.sub_units}.flatten
  end

  def sub_institutions
    institutions + sub_organization_units.map { |x| x.sub_institutions }.flatten
  end

  def sub_users
    (users + sub_organization_units.collect{|x| x.sub_users}).flatten
  end

  def all_contacts
    Contact.where('organization_unit_id in (?)', (sub_units.pluck(:id) << self.id)).pluck(:id)
  end

  def sub_contacts
    Contact.where('organization_unit_id = ? ', self.id)
  end

  def sub_equipment
    Equipment.where('equipment.organization_unit_id in (?)', (sub_units.pluck(:id) << id))
  end

  def sub_receive
    (receive + sub_organization_units.collect{|x| x.sub_receive}).flatten
  end

  def sub_store_registrations
    (store_registrations + sub_organization_units.collect{|x| x.sub_store_registrations} + facilities.collect{|x| x.store_registrations}).flatten
  end

  def sub_inventories
    inventories + sub_units.collect{ |x| x.inventories }.flatten
  end

  def to_s
    name
  end

end
