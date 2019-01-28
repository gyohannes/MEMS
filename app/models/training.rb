class Training < ApplicationRecord
  belongs_to :contact

  accepts_nested_attributes_for :contact, allow_destroy: true

end
