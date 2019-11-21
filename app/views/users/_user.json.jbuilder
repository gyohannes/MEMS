json.extract! user, :id, :email, :password, :password_confirmation, :first_name, :father_name, :grand_father_name, :organization_unit_id, :facility_id, :institution_id, :created_at, :updated_at
json.url user_url(user, format: :json)
