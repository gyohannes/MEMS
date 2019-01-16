class Institution < ApplicationRecord
  belongs_to :organization_structure
  has_many :procurement_requests
  has_many :specification_requests
  has_many :spare_part_requests
  has_many :acceptance_requests
  has_many :training_requests
  has_many :installation_requests
  has_many :maintenance_requests
  has_many :calibration_requests
  has_many :maintenance_toolkit_requests

  scope :suppliers, -> { where(category: 'Supplier') }
  scope :local_representatives, -> { where(category: 'Local Representative') }

  def to_s
    name
  end

end
