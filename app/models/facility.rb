class Facility < ApplicationRecord
  belongs_to :organization_structure
  belongs_to :facility_type
  has_many :equipment
  has_many :contacts

  has_many :procurement_requests
  has_many :specification_requests
  has_many :spare_part_requests
  has_many :acceptance_requests
  has_many :training_requests
  has_many :installation_requests
  has_many :maintenance_requests
  has_many :calibration_requests
  has_many :disposal_requests
  has_many :budget_requests
  has_many :maintenance_toolkit_requests

  validates :population, numericality: {greater_than: 0}

  def to_s
    name
  end

end
