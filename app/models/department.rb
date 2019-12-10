class Department < ApplicationRecord
  belongs_to :organization_unit
  has_many :notifications
  has_many :equipment

  validates :name, presence: true

  def to_s
    name
  end

end
