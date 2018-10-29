class Receive < ApplicationRecord
  belongs_to :store
  has_many :receive_equipments

  accepts_nested_attributes_for :receive_equipments, allow_destroy: true

end
