class Equipment < ApplicationRecord
  belongs_to :facility
  belongs_to :equipment_category
  belongs_to :supplier, optional: true, :class_name => 'Institution', :foreign_key => "supplier_id"
  belongs_to :local_representative, optional: true, :class_name => 'Institution', :foreign_key => "local_representative_id"
  has_one :installation
  has_one :acceptance_test
  has_many :maintenances
  has_one :disposal

  STATUSES = [NEW='New', FUNCTIONAL='Functional', NOT_FUNCTIONAL='Not Functional', DISPOSED='Disposed']

  FUNCTIONAL_STATUSES = [FUNCTIONAL='Functional', NOT_FUNCTIONAL='Not Functional']
  scope :active, -> { where.not(status: self::DISPOSED)}

  def trainings
    return Training.where('equipment_name = ? and model = ?', equipment_name, model)
  end

  def to_s
    [equipment_name, model].join(' - ')
  end
end
