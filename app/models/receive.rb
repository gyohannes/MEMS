class Receive < ApplicationRecord
  belongs_to :store
  has_many :receive_spare_parts
  has_many :receive_equipment

  accepts_nested_attributes_for :receive_spare_parts, allow_destroy: true
  accepts_nested_attributes_for :receive_equipment, allow_destroy: true

  validates :deliverer_name, :recipient_name, :receive_date, presence: true

end
