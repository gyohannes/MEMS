class Store < ApplicationRecord
  belongs_to :organization_structure, optional: true
  belongs_to :facility, optional: true

  def to_s
    store_name
  end
end
