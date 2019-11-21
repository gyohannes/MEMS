class Store < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :facility, optional: true
  has_many :receive
  has_many :store_registrations

  validates :store_name, :block_number, :room_number, presence: true

  def to_s
    store_name
  end
end
