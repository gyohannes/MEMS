json.extract! installation, :id, :equipment_id, :department_id, :block_number, :date_of_intallation, :warranty_period, :preventive_maintenance_date, :installed_by, :contact_address, :installation_cost, :note, :created_at, :updated_at
json.url installation_url(installation, format: :json)
