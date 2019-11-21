class Maintenance < ApplicationRecord
  belongs_to :equipment
  belongs_to :maintenance_request, optional: true
  belongs_to :maintenance_work_order, optional: true
  belongs_to :status

end
