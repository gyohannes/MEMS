class Equipment < ApplicationRecord
  belongs_to :facility, optional: true
  belongs_to :equipment_category, optional: true
  belongs_to :supplier, optional: true, :class_name => 'Institution', :foreign_key => "supplier_id"
  belongs_to :local_representative, optional: true, :class_name => 'Institution', :foreign_key => "local_representative_id"
  has_one :installation
  has_one :acceptance_test
  has_many :maintenances
  has_one :disposal
  has_many :inventories

  after_find :set_use_of_years
  after_find :set_date_of_installation
  after_find :set_trained_end_users
  after_find :set_trained_maintenance_personnel

  validates :equipment_name, :model, :serial_number, :tag_number, presence: true

  STATUSES = [NEW='New', UNDER_MAINTENANCE = 'Under Maintenance', FUNCTIONAL='Functional', NOT_FUNCTIONAL='Not Functional', DISPOSED='Disposed']

  FUNCTIONAL_STATUSES = [FUNCTIONAL='Functional', NOT_FUNCTIONAL='Not Functional']
  scope :active, -> { where.not(status: self::DISPOSED)}

  def preventive_maintenance_date
    dates = []
    dates << installation.preventive_maintenance_date unless installation.blank?
    dates << maintenances.sort_by{|x| x.end_date }.last unless maintenances.blank?
    return dates.sort.last
  end
  def set_trained_end_users
    self.trained_end_users = !trainings.joins(:contact).where('contacts.facility_id = ? and training_type = ?',
                                     facility_id, Constants::END_USER).blank?
  end

  def set_trained_maintenance_personnel
    self.trained_maintenance_personnel= !trainings.joins(:contact).where('contacts.facility_id = ? and training_type = ?',
                                     facility_id, Constants::MAINTENANCE_PERSONNEL).blank?
  end

  def set_date_of_installation
   self.date_of_installation = installation.try(:date_of_installation)
  end

  def set_use_of_years
    self.use_of_years = self.use_of_years || 0 + (Date.today - (set_date_of_installation || Date.today))/365
  end

  def trainings
    return Training.where('equipment_name = ? and model = ?', equipment_name, model)
  end

  def self.search(term, facility=nil)
    if facility
      facility.equipment.where('LOWER(equipment_name) LIKE :term', term: "%#{term.downcase}%")
    else
      where('LOWER(equipment_name) LIKE :term', term: "%#{term.downcase}%")
    end
  end

  def to_s
    [equipment_name, model].join(' - ')
  end
end
