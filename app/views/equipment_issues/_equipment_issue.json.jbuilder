json.extract! equipment_issue, :id, :sub_distribution_id, :quantity, :issued_by, :issue_date, :remark, :GRV_number, :STV_number, :model, :received_by, :receiver_contact_address, :created_at, :updated_at
json.url equipment_issue_url(equipment_issue, format: :json)
