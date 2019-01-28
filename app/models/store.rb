class Store < ApplicationRecord
  belongs_to :organization_structure, optional: true
  belongs_to :facility, optional: true
  has_many :receive
  has_many :store_registrations

  def to_s
    store_name
  end
end
