class ProcurementRequestSparePart < ApplicationRecord
  belongs_to :procurement_request
  belongs_to :spare_part
end
