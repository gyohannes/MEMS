class Institution < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :facility, optional: true
  has_many :procurement_requests
  has_many :specification_requests
  has_many :spare_part_requests
  has_many :acceptance_requests
  has_many :training_requests
  has_many :installation_requests
  has_many :maintenance_requests
  has_many :calibration_requests
  has_many :maintenance_toolkit_requests
  has_many :users
  has_many :forwards, dependent: :destroy

  scope :suppliers, -> { where(category: 'Supplier') }
  scope :local_representatives, -> { where(category: 'Local Representative') }

  validates :name, presence: true

  def to_s
    name
  end

end
