json.extract! calibration_request, :id, :organization_unit_id, :facility_id, :equipment_id, :calibration_description, :requested_to, :request_to_org_structure, :request_to_facility, :request_to_institution, :requested_by, :request_date, :created_at, :updated_at
json.url calibration_request_url(calibration_request, format: :json)
