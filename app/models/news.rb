class News < ApplicationRecord
  belongs_to :user
  belongs_to :organization_structure, optional: true
  belongs_to :facility, optional: true
  belongs_to :institution, optional: true

  scope :latest_news, -> {order('created_at DESC').first(5)}

  def created_by
    organization_structure ? organization_structure : (facility ? facility : (institution ? institution : nil))
  end
end
