class Notification < ApplicationRecord
  belongs_to :organization_unit
  belongs_to :notifiable, polymorphic: true
end
