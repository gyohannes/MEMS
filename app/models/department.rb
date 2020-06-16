class Department < ApplicationRecord
  belongs_to :organization_unit, optional: true
  has_many :notifications
  has_many :equipment

  validates :name, presence: true

  def to_s
    name
  end

end
