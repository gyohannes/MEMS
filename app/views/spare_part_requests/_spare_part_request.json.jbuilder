json.extract! spare_part_request, :id, :organization_structure_id, :facility_id, :spare_part_name, :model, :volts_ampere, :power_requirement, :quantity, :requested_to, :request_to_org_structure, :request_to_facility, :request_to_institution, :requested_by, :request_date, :created_at, :updated_at
json.url spare_part_request_url(spare_part_request, format: :json)
