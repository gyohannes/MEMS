class EpsaHub < ApplicationRecord
  belongs_to :institution
  has_many :sub_distributions
  has_many :equipment_issues, through: :sub_distributions

  def new_requests
    sub_distributions.includes(:equipment_issue).where(equipment_issues: {id: nil})
  end

  def to_s
    name
  end
end
