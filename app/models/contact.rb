class Contact < ApplicationRecord
  belongs_to :facility, optional: true
  belongs_to :organization_unit, optional: true

  validates :name_of_contact, :profession, :title, :phone_number, :work_place, presence: true

  def self.search(term, user)
    user.load_contacts.where('LOWER(name_of_contact) LIKE :term', term: "%#{term.downcase}%")
  end

  def to_s
    name_of_contact
  end

end
