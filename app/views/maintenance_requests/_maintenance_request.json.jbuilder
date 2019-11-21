json.extract! maintenance_request, :id, :organization_unit_id, :facility_id, :equipment_id, :maintenance_type, :maintenance_description, :requested_to, :request_to_org_structure, :request_to_facility, :request_to_institution, :requested_by, :request_date, :created_at, :updated_at
json.url maintenance_request_url(maintenance_request, format: :json)
