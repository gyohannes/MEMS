class Facility < ApplicationRecord
  belongs_to :organization_structure
  belongs_to :facility_type
  has_many :equipment
  has_many :contacts

  validates :population, numericality: {greater_than: 0}

  def to_s
    name
  end

end
