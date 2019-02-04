class Maintenance < ApplicationRecord

  belongs_to :equipment
  belongs_to :maintenance_request, optional: true

end
