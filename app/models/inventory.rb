class Inventory < ApplicationRecord
  belongs_to :equipment
  belongs_to :status

  accepts_nested_attributes_for :equipment, allow_destroy: true
  validates :inventory_date, presence: true

  def trained_end_users
    return trained_end_users? == true ? 'Yes' : 'No'
  end

  def trained_maintenance_personnel
    return trained_maintenance_personnel? == true ? 'Yes' : 'No'
  end

end
