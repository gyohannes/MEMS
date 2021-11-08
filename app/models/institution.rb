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
  has_many :epsa_teams
  has_many :epsa_hubs
  has_many :request_statuses, through: :epsa_teams
  has_many :distributions
  has_many :sub_distributions, through: :distributions

  validates :name, presence: true

  scope :suppliers, -> { where(category: 'Supplier') }
  scope :local_representatives, -> { where(category: 'Local Representative') }

  before_save :set_name

  def set_name
    self[:name] = name.titlecase  unless name.blank?
  end

  def new_requests
    request_statuses.where(epsa_status_id: nil)
  end

  def new_distribution_requests
    distributions.joins(:sub_distributions).where(sub_distributions: {status: nil}).uniq
  end

  def to_s
    name
  end

end
