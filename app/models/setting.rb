class Setting < ApplicationRecord
  has_one_attached :user_guide

  validates :user_guide, presence: true

end
