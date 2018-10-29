json.extract! facility, :id, :organization_structure_id, :name, :facility_type_id, :category, :url, :latitude, :longitude, :contact_person, :contact_phone, :created_at, :updated_at
json.url facility_url(facility, format: :json)
