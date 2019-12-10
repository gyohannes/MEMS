class Forward < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :institution, optional: true
  belongs_to :forwardable, polymorphic: true
end
