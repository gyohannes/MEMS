class EquipmentCategory < ApplicationRecord
  has_many :equipment

  validates :name, presence: true

  def to_s
    name
  end

end
