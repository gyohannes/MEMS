class Facility < ApplicationRecord
  belongs_to :organization_structure
  belongs_to :facility_type
  has_many :equipment
  has_many :inventories, through: :equipment
  has_many :contacts
  has_many :users
  has_many :stores
  has_many :store_registrations, through: :stores
  has_many :receive, through: :stores
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
  has_many :institutions

  validates :population, numericality: {greater_than: 0}, allow_blank: true

  def to_s
    name
  end

end
