json.extract! procurement_request, :id, :organization_structure_id, :facility_id, :requested_by, :contact_phone, :contact_email, :request_to, :created_at, :updated_at
json.url procurement_request_url(procurement_request, format: :json)
