class Specification < ApplicationRecord
  belongs_to :equipment_name
  belongs_to :organization_unit, optional: true
  belongs_to :facility, optional: true

  has_attached_file :attachment
  validates_attachment_content_type :attachment, content_type: ['application/pdf']

  validates :equipment_name_id, :specification_by, :description, :contact_address, :specification_date, presence: true

end
