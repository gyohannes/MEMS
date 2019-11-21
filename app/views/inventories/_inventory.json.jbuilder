json.extract! inventory, :id, :equipment_id, :status, :description_of_problem, :trained_end_users, :trained_maintenance_personnel, :suggestion, :risk_level, :inventory_date, :inventory_done_by, :contact_address, :note, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
