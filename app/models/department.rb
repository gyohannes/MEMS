class Department < ApplicationRecord
  has_many :installations
  has_many :equipment, through: :installations

  validates :name, presence: true

  def department_equipment(facility)
    equipment.where('equipment.facility_id = ?', facility)
  end

  def to_s
    name
  end

end
