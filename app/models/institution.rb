class Institution < ApplicationRecord
  belongs_to :organization_structure

  scope :suppliers, -> { where(category: 'Supplier') }
  scope :local_representatives, -> { where(category: 'Local Representative') }

  def to_s
    name
  end

end
