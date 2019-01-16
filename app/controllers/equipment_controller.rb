class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update]

  def load
    @suppliers = Institution.suppliers
    @local_representatives = Institution.local_representatives
  end

  def load_calendar
    calendars = []
    equipment = current_user.load_equipment.pluck(:id)
    installations = Installation.where('equipment_id in (?)', equipment)
    maintenances = Maintenance.where('equipment_id in (?)', equipment)

    installations.each do |ins|
      calendars << {title: ins.equipment.to_s + ' Preventive Maintenance',
                    start: ins.preventive_maintenance_date }
    end

    maintenances.each do |m|
      calendars << {title: m.equipment.to_s + ' Preventive Maintenance',
                    start: m.preventive_maintenance_date }
    end

    render json: calendars
  end

  def equipment_by_status
    equipment = []
    if !current_user.facility.blank?
      equipment = current_user.facility.equipment.group('status').count
    elsif !current_user.organization_structure.blank?
      equipment = current_user.organization_structure.sub_equipment.group('status').count
    end
    render json: equipment
  end

  def equipment_by_category
    equipment = []
    if !current_user.facility.blank?
      equipment = current_user.facility.equipment.
          joins(:equipment_category).group('equipment_categories.name').count
    elsif !current_user.organization_structure.blank?
      equipment = current_user.organization_structure.sub_equipment.
          joins(:equipment_category).group('equipment_categories.name').count
    end
    render json: equipment
  end

  # GET /equipment
  # GET /equipment.json
  def index
    @equipment = []
    if current_user.organization_structure
      @equipment = current_user.organization_structure.try(:sub_equipment)
    elsif current_user.facility and current_user.department
      @equipment = current_user.department.department_equipment(current_user.facility_id)
    elsif current_user.facility
      @equipment = current_user.facility.equipment
    end
    return @equipment
  end

  def load_equipment
    @organization_structure  = OrganizationStructure.find(params[:node])
    @equipment = @organization_structure.sub_equipment
    render partial: 'equipment'
  end
  # GET /equipment/1
  # GET /equipment/1.json
  def show
  end

  # GET /equipment/new
  def new
    @equipment = Equipment.new
    @organization_structure = OrganizationStructure.find(params[:organization_structure])
    @facilities = @organization_structure.facilities
    @equipment.status = Equipment::NEW
  end

  # GET /equipment/1/edit
  def edit
    @organization_structure = @equipment.facility.organization_structure
    @facilities = @organization_structure.facilities
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)
    @organization_structure = OrganizationStructure.find(params[:organization_structure])
    @facilities = @organization_structure.facilities
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
    @organization_structure = @equipment.facility.organization_structure
    @facilities = @organization_structure.facilities
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
      params.require(:equipment).permit(:facility_id, :equipment_name, :equipment_category_id, :model, :serial_number, :tag_number, :volt_ampere, :power_requirement, :manufacturer, :country, :manufactured_year, :purchased_year, :purchase_price, :supplier_id, :manual_attached, :warranty_agreement_note, :local_representative_id, :remark, :status)
    end
end
