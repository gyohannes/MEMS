class Distribution < ApplicationRecord
  belongs_to :equipment_name
  has_many :sub_distributions

  accepts_nested_attributes_for :sub_distributions, allow_destroy: true

  validates :distribution_date, presence: true

  def total_number_distributed
    sub_distributions.pluck(:number_of_equipment).sum
  end

end
