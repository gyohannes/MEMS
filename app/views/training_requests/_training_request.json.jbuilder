json.extract! training_request, :id, :organization_unit_id, :facility_id, :trainee_type, :training_description, :requested_to, :request_to_org_structure, :request_to_facility, :request_to_institution, :requested_by, :request_date, :created_at, :updated_at
json.url training_request_url(training_request, format: :json)
