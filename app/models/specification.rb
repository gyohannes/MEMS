class Specification < ApplicationRecord
  belongs_to :organization_structure, optional: true
  belongs_to :facility, optional: true

  has_attached_file :attachment
  validates_attachment_content_type :attachment, content_type: ['application/pdf']

  validates :equipment_name, :specification_by, :description, :contact_address, :specification_date, presence: true

end
