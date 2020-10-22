class SubDistribution < ApplicationRecord
  belongs_to :distribution
  belongs_to :organization_unit
end
