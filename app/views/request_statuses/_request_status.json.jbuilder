json.extract! request_status, :id, :procurement_request_id, :epsa_team_id, :epsa_status_id, :status_date, :created_at, :updated_at
json.url request_status_url(request_status, format: :json)
