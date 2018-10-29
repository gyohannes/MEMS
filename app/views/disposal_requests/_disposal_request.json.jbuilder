json.extract! disposal_request, :id, :organization_structure_id, :facility_id, :equipment_id, :disposal_description, :requested_to, :request_to_org_structure, :request_to_facility, :contact_address, :requested_by, :request_date, :created_at, :updated_at
json.url disposal_request_url(disposal_request, format: :json)
