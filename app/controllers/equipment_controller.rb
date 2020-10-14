class EquipmentController < ApplicationController
  load_and_authorize_resource
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Equipment", :equipment_index_path

  def load
    @suppliers = Institution.suppliers
    @local_representatives = Institution.local_representatives
  end

  def load_calendar
    calendars = []
    equipment = current_user.load_equipment

    equipment.each do |m|
      calendars << {title: m.to_s + ' Preventive Maintenance',
                    start: m.preventive_maintenance_date }
    end

    render json: calendars
  end

  def import
    add_breadcrumb "Import", :import_equipment_index_path
    if request.post?
      @equipments = Equipment.import_equipments(params[:equipments_csv_file], current_user)
      flash[:notice] = @equipments.blank? ? 'No equipments imported' : 'Equipments imported. Check the imported list below'
    end
  end

  def search
    equipments = Equipment.search(params[:term]).uniq{ |e| e.equipment_name}
    render json: equipments
  end

  def facility_equipment_search
    equipments = Equipment.search(nil, current_user.organization_unit_id,nil,nil,nil,nil,params[:term])
    render json: equipments
  end

  def equipment_by_status
    equipment = current_user.load_equipment.joins(:status).group('statuses.name').count
    render json: equipment
  end

  def equipment_by_type
    equipment = current_user.load_equipment.joins(:equipment_type).group('equipment_types.name').count
    render json: equipment
  end

  def ideal_vs_available_by_type
    org_unit = current_user.organization_unit
    equipment = []
    OrganizationUnit::STANDARD_VS_AVAILABLE.each do |status|
      equipment << {name: status, data: EquipmentName.all.map{|eq| [eq.to_s, org_unit.ideal_vs_available(eq.id,status)]} }
    end
    render json: equipment
  end

  def equipment_by_department
    equipment = []
    Status.all.each do |s|
      equipment << {name: s.name, data: Department.all.map{|d| [d.name, current_user.load_equipment.where(status_id: s, department_id: d.id).count]}}
    end
    render json: equipment
  end

  def equipment_by_org_unit_and_status
    equipment = []
    current_user.organization_unit.sub_organization_units.each do |ou|
      equipment << {name: ou.to_s, data: Status.all.map{|s| [s.to_s, ou.sub_equipment.where(status_id: s).count]} }
    end
    render json: equipment
  end

  def equipment_by_facility_and_type
    equipment = []
    current_user.organization_unit.facilities.each do |ou|
      equipment << {name: ou.to_s, data: EquipmentType.all.map{|t| [t.to_s, ou.equipment.where(equipment_type_id: t).count]} }
    end
    render json: equipment
  end

  def equipment_by_org_unit_and_type
    equipment = []
    current_user.organization_unit.sub_organization_units.each do |ou|
      equipment << {name: ou.to_s, data: EquipmentType.all.map{|t| [t.to_s, ou.sub_equipment.where(equipment_type_id: t).count]} }
    end
    render json: equipment
  end

  # GET /equipment
  # GET /equipment.json
  def index
    @equipment = current_user.organization_unit == OrganizationUnit.top_organization_unit ? [] : current_user.load_equipment
  end

  def load_equipment
    @organization_unit  = OrganizationUnit.find(params[:node])
    @equipment = @organization_unit.sub_equipment
    render partial: 'equipment'
  end
  # GET /equipment/1
  # GET /equipment/1.json
  def show
    add_breadcrumb "Details", :equipment_path
  end

  # GET /equipment/new
  def new
    add_breadcrumb "Registration", :new_equipment_path
    @equipment = Equipment.new
  end

  # GET /equipment/1/edit
  def edit
    add_breadcrumb "Edit", :edit_equipment_path
    @organization_unit = @equipment.organization_unit
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)
    @equipment.organization_unit_id = current_user.organization_unit_id
    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @equipment, notice: 'Equipment was successfully created.' }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment/1
  # PATCH/PUT /equipment/1.json
  def update
    respond_to do |format|
      if @equipment.update(equipment_params)
        format.html { redirect_to @equipment, notice: 'Equipment was successfully updated.' }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    @equipment.destroy
    respond_to do |format|
      format.html { redirect_to equipment_index_url, notice: 'Equipment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment
      @equipment = Equipment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_params
      params.require(:equipment).permit(:organization_unit_id, :equipment_name_id, :equipment_type_id, :model, :serial_number, :tag_number,
                                        :volt_ampere, :power_requirement, :maintenance_requirement_id, :manufacturer, :country, :manufactured_year, :purchased_year,
                                        :purchase_price, :supplier_id, :manual_attached, :warranty_expire_date, :institution_id,
                                        :status_id, :acquisition_type, :inventory_number, :equipment_risk_classification, :installation_date,
                                        :warranty_expire_date, :maintenance_service_provider, :description, :years_used, :order_number, :cost,
                                        :estimated_life_span, :department_id, :location, documents_attributes: [:id, :name, :attachment, :_destroy])
    end
end
