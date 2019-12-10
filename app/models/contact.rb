class Contact < ApplicationRecord
  belongs_to :organization_unit

  validates :name, :profession, :title, :phone_number, :work_place, presence: true

  def self.search(term, user)
    user.load_contacts.where('LOWER(name) LIKE :term', term: "%#{term.downcase}%")
  end

  def country_name
    country = ISO3166::Country[nationality]
    country.translations[I18n.locale.to_s] || country.name
  end

  def to_s
    name
  end

end
