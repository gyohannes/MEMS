class IssueSparePart < ApplicationRecord
  belongs_to :issue
  belongs_to :spare_part

  validate :issue_must_not_exceed_available

  def issue_must_not_exceed_available
    available = spare_part.receive_spare_parts.pluck(:quantity).sum - spare_part.issue_spare_parts.where.not(id: self.id).pluck(:quantity).sum
    unless quantity.blank?
      if quantity > available
        errors.add(:quantity, "should not exceed the available amount (#{available})")
      end
    end
  end
end
