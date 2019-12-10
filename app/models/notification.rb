class Notification < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :institution, optional: true
  belongs_to :department, optional: true
  belongs_to :user, optional: true
  belongs_to :notifiable, polymorphic: true
  has_many :notification_user_visits

  def read(user)
    !notification_user_visits.where(user_id: user).blank?
  end

end
