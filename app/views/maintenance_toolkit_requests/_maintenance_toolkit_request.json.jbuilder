json.extract! maintenance_toolkit_request, :id, :organization_structure_id, :facility_id, :toolkit_name, :toolkit_description, :quantity, :requested_to, :request_to_org_structure, :request_to_facility, :requested_by, :contact_address, :request_date, :created_at, :updated_at
json.url maintenance_toolkit_request_url(maintenance_toolkit_request, format: :json)
