json.extract! installation_request, :id, :organization_unit_id, :facility_id, :equipment_name_id, :model, :installation_description, :requested_to, :request_to_org_structure, :request_to_facility, :request_to_institution, :requested_by, :request_date, :created_at, :updated_at
json.url installation_request_url(installation_request, format: :json)
