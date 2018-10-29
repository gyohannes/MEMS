class OrganizationStructure < ApplicationRecord
  belongs_to :organization_structure_type
  belongs_to :parent_organization_structure, optional: true, :class_name => 'OrganizationStructure', :foreign_key => "parent_organization_structure_id"
  has_many :sub_organization_structures, :class_name => 'OrganizationStructure', :foreign_key => "parent_organization_structure_id"
  has_many :users
  has_many :facilities
  has_many :institutions
  has_many :contacts
  has_many :equipment, through: :facilities

  def top_organization_unit_exists?
    !OrganizationStructure.top_organization_unit.blank?
  end

  def self.top_organization_structure
    where('parent_organization_structure_id is null').first
  end

  def self.facilities_tree
    parent = OrganizationStructure.top_organization_structure
    [parent.facility_children]
  end

  def self.organization_tree(user)
    parent = user.try(:super_admin?) ? OrganizationStructure.top_organization_structure : user.try(:organization_structure)
    [parent.org_children]
  end

  def org_children
    {
        text: name << " <i>[#{organization_structure_type}]</i> ",
        type: 'org unit',
        id: id,
        nodes: sub_organization_structures.blank? ? nil
                   : sub_organization_structures.collect{|x| x.org_children }
    }
  end

  def facility_children
    fnodes = facility_nodes
    {
        text: name << " <i>[#{organization_structure_type}]</i> ",
        type: 'org unit',
        id: id,
        nodes: fnodes.blank? ? sub_organization_structures.collect{|x| x.facility_children }
                   : fnodes.map { |fn| sub_organization_structures.collect{|x| x.facility_children } << fn}.flatten
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
    sub_organization_structures + sub_organization_structures.collect{|x| x.sub_units}.flatten
  end

  def sub_facilities
    facilities + sub_organization_structures.collect{|x| x.sub_facilities}.flatten
  end

  def sub_institutions
    institutions + sub_organization_structures.map { |x| x.sub_institutions }.flatten
  end

  def sub_users
    users + sub_organization_structures.collect{|x| x.sub_users}.flatten
  end

  def sub_contacts
    contacts + sub_organization_structures.collect{|x| x.sub_contacts}.flatten
  end

  def sub_equipment
    Equipment.joins(:facility).where('organization_structure_id in (?)', (sub_units.pluck(:id) << id))
  end

  def to_s
    name
  end

end
