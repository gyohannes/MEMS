json.extract! budget_request, :id, :organization_unit_id, :facility_id, :budget_name, :budget_description, :amount, :requested_to, :request_to_org_structure, :request_to_facility, :contact_address, :requested_by, :request_date, :created_at, :updated_at
json.url budget_request_url(budget_request, format: :json)
