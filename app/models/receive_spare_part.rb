class ReceiveSparePart < ApplicationRecord
  belongs_to :receive
  belongs_to :spare_part
end
