class SubDistribution < ApplicationRecord
  belongs_to :distribution
  belongs_to :organization_unit

  validates :number_of_equipment, presence: true

end
