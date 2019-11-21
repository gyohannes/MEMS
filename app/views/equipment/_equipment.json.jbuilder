json.extract! equipment, :id, :facility_id, :equipment_name_id, :model, :serial_number, :tag_number, :volt_ampere, :power_requirement, :manufacturer, :country, :manufactured_year, :purchased_year, :purchase_price, :supplier_id, :manual_attached, :warranty_agreement_note, :local_representative_id, :remark, :status, :created_at, :updated_at
json.url equipment_url(equipment, format: :json)
