class StoreRegistration < ApplicationRecord
  belongs_to :store
  belongs_to :equipment, optional: true

  accepts_nested_attributes_for :equipment, allow_destroy: true

end
