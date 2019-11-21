json.extract! notification, :id, :organization_unit_id, :name, :notifiable_id, :created_at, :updated_at
json.url notification_url(notification, format: :json)
