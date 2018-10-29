class SparePartRequest < ApplicationRecord
  belongs_to :organization_structure
  belongs_to :facility
end
