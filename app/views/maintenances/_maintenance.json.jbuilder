json.extract! maintenance, :id, :equipment_id, :maintenance_type, :problem, :action_taken, :spare_parts_used, :start_date, :end_date, :maintenance_cost, :maintained_by, :contact_address, :preventive_maintenance_date, :note, :created_at, :updated_at
json.url maintenance_url(maintenance, format: :json)
