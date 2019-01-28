class Receive < ApplicationRecord
  belongs_to :store
  has_many :receive_equipments

  accepts_nested_attributes_for :receive_equipments, allow_destroy: true

  validates :deliverer_name, :recipient_name, :delivery_date, presence: true

end
