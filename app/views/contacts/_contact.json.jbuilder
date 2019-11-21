json.extract! contact, :id, :facility_id, :name_of_contact, :profession, :title, :work_place, :city, :phone_number, :country, :email, :created_at, :updated_at
json.url contact_url(contact, format: :json)
