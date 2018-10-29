class TrainingRequest < ApplicationRecord
  belongs_to :organization_structure
  belongs_to :facility
end
