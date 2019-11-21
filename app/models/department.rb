class Department < ApplicationRecord
  belongs_to :organization_unit
  has_many :installations
  has_many :equipment, through: :installations

  validates :name, presence: true

  def department_equipment(facility)
    equipment.where('equipment.organization_unit_id = ?', facility)
  end

  def to_s
    name
  end

end
