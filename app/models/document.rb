class Document < ApplicationRecord
  belongs_to :documentable, polymorphic: true
  has_one_attached :attachment

  validates :name, :attachment, presence: true

end
