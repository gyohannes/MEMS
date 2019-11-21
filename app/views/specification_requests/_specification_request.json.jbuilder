json.extract! specification_request, :id, :organization_unit_id, :facility_id, :requested_to, :requested_to_org_structure, :requested_to_org_facility, :requested_to_org_institution, :equipment_name_id, :quantity, :requested_by, :requested_date, :created_at, :updated_at
json.url specification_request_url(specification_request, format: :json)
