class EquipmentIssue < ApplicationRecord
  belongs_to :sub_distribution

  def to_s
    sub_distribution
  end
end
