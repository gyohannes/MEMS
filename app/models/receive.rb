class Receive < ApplicationRecord
  belongs_to :store
  has_many :receive_spare_parts

  accepts_nested_attributes_for :receive_spare_parts, allow_destroy: true

  validates :deliverer_name, :recipient_name, :receive_date, presence: true

end
