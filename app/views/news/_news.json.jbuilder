json.extract! news, :id, :user_id, :organization_structure_id, :facility_id, :institution_id, :headline, :content, :created_at, :updated_at
json.url news_url(news, format: :json)
