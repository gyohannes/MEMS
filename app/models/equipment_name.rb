class EquipmentName < ApplicationRecord
  belongs_to :equipment_type
  has_many :model_equipments
  has_many :equipment

  validates :name, :code, presence: true


  def self.import_names(file)
    names = []
    CSV.foreach(file.path, :headers=>true, encoding: 'iso-8859-1:utf-8') do |row|
      name = row[0]
      code = row[1]
      equipment_type = row[2].blank? ? nil : EquipmentType.find_or_create_by(name: row[2])
      attrbts = {equipment_type_id: equipment_type.try(:id), name: name, code: code}
      eq_name = EquipmentName.create(attrbts)
      names << eq_name unless eq_name.blank?
    end
    return names
  end


  def to_s
    name
  end

end
