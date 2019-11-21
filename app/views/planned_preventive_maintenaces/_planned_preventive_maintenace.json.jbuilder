json.extract! planned_preventive_maintenace, :id, :user_id, :equipment_id, :action_taken, :maintained_date, :maintenace_cost, :enginneer_name_and_address, :next_ppm, :note, :created_at, :updated_at
json.url planned_preventive_maintenace_url(planned_preventive_maintenace, format: :json)
