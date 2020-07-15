class Specification < ApplicationRecord
  belongs_to :equipment_name
  belongs_to :organization_unit_type
  belongs_to :department

  validates :item_detail, presence: true

  def self.import_specifications(file)
    specifications = []
    CSV.foreach(file.path, :headers=>true, encoding: 'iso-8859-1:utf-8') do |row|
      equipment_name = row[0].blank? ? nil : EquipmentName.find_or_create_by(name: row[0])
      department = row[1].blank? ? nil : Department.find_or_create_by(name: row[1])
      organization_type = row[2].blank? ? nil : OrganizationUnitType.find_or_create_by(name: row[2])
      item_detail = row[3]

      attrbts = {equipment_name_id: equipment_name.try(:id), department_id: department.try(:id),
                 organization_unit_type_id: organization_type.try(:id), item_detail: item_detail }
      specification = Specification.find_by(attrbts)
      if specification.blank?
        sp = Specification.new(attrbts)
        if sp.save
          specifications << sp unless sp.blank?
        end
      end
    end
    return specifications
  end

  def to_s
    equipment_name
  end

end
