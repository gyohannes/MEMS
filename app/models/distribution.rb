class Distribution < ApplicationRecord
  belongs_to :equipment_name
  belongs_to :institution
  has_many :sub_distributions, dependent: :destroy

  accepts_nested_attributes_for :sub_distributions, allow_destroy: true

  validates :request_date, presence: true

  def total_quantity
    sub_distributions.pluck(:quantity).sum
  end

  def to_s
    equipment_name.name
  end

end
