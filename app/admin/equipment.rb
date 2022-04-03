ActiveAdmin.register Equipment do

  index do
    selectable_column
    column :organization_unit
    column :equipment_name
    column :model
    column :serial_number
    column :department
    column :inventory_number
    column :status
    actions
    # OR actions :index, :new, :create
  end

  #Filters  
  filter :organization_unit
  filter :equipment_name
  filter :inventory_number
  filter :status
  filter :model
  filter :serial_number
  filter :department

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :organization_unit_id, :equipment_name_id, :inventory_number, :description, :equipment_type_id, :department_id, :location, :installation_date, :warranty_expire_date, :maintenance_service_provider, :acquisition_type, :equipment_risk_classification, :model, :order_number, :cost, :serial_number, :tag_number, :manufacturer, :country, :manufactured_year, :purchased_year, :power_requirement, :maintenance_requirement_id, :estimated_life_span, :years_used, :institution_id, :trained_end_users, :trained_technical_personnel, :status_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:organization_unit_id, :equipment_name_id, :inventory_number, :description, :equipment_type_id, :department_id, :location, :installation_date, :warranty_expire_date, :maintenance_service_provider, :acquisition_type, :equipment_risk_classification, :model, :order_number, :cost, :serial_number, :tag_number, :manufacturer, :country, :manufactured_year, :purchased_year, :power_requirement, :maintenance_requirement_id, :estimated_life_span, :years_used, :institution_id, :trained_end_users, :trained_technical_personnel, :status_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
