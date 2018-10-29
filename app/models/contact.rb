class Contact < ApplicationRecord
  belongs_to :facility, optional: true
  belongs_to :organization_structure, optional: true

  def to_s
    name_of_contact
  end

end
