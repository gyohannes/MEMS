json.extract! maintenance_work_order, :id, :equipment_id, :user_id, :location, :date, :description_of_problem, :created_at, :updated_at
json.url maintenance_work_order_url(maintenance_work_order, format: :json)
