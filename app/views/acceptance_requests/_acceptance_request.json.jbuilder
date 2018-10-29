json.extract! acceptance_request, :id, :organization_structure_id, :facility_id, :equipment_name_id, :model, :volts_ampere, :power_requirement, :description, :requested_to, :request_to_org_structure, :request_to_facility, :request_to_institution, :requested_by, :request_date, :created_at, :updated_at
json.url acceptance_request_url(acceptance_request, format: :json)
