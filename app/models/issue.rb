class Issue < ApplicationRecord
  belongs_to :store
  has_many :issue_spare_parts

  accepts_nested_attributes_for :issue_spare_parts, allow_destroy: true
end
