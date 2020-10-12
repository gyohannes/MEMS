class InventoriesController < ApplicationController
  include ApplicationHelper
  load_and_authorize_resource
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Inventories", :inventories_path
  # GET /inventories
  # GET /inventories.json
  def index
    @inventories = current_user.organization_unit.sub_inventories
  end

  def load_facility_equipment
    @equipment = Equipment.search(nil, current_user.organization_unit_id,nil,nil,nil,nil,params[:term]).first
    render partial: 'equipment'
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
    add_breadcrumb "Details", :inventory_path
  end

  # GET /inventories/new
  def new
    add_breadcrumb "Register", :new_inventory_path
    @inventory = Inventory.new
    equipment = Equipment.find_by(id: params[:equipment])
    @inventory.equipment = equipment || Equipment.new
    session[:return_to] = request.referer
  end

  # GET /inventories/1/edit
  def edit
    add_breadcrumb "Edit", :edit_inventory_path
    session[:return_to] = request.referer
    @equipment = @inventory.equipment
  end

  # POST /inventories
  # POST /inventories.json
  def create
    @inventory = Inventory.new(inventory_params)
    params[:inventory][:trained_end_users] = to_boolean(params[:trained_end_users])
    params[:inventory][:trained_maintenance_personnel] = to_boolean(params[:trained_technical_personnel])
    @inventory.user_id = current_user.id
    @equipment = @inventory.equipment
    respond_to do |format|
      if @inventory.save
        @equipment.update(status: @inventory.status)
        format.html { redirect_to session.delete(:return_to), notice: 'Inventory was successfully created.' }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventories/1
  # PATCH/PUT /inventories/1.json
  def update
    params[:inventory][:trained_end_users] = to_boolean(params[:trained_end_users])
    params[:inventory][:trained_maintenance_personnel] = to_boolean(params[:trained_technical_personnel])
    @inventory.user_id = current_user.id
    @equipment = @inventory.equipment

    respond_to do |format|
      if @inventory.update(inventory_params)
        @inventory.equipment.update(status: @inventory.status )
        format.html { redirect_to session.delete(:return_to), notice: 'Inventory was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventory }
      else
        format.html { render :edit }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json
  def destroy
    @inventory.destroy
    respond_to do |format|
      format.html { redirect_to inventories_url, notice: 'Inventory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_params
      params.require(:inventory).permit(:equipment_id, :status_id, :user_id, :description_of_problem, :trained_end_users,
                                        :trained_maintenance_personnel, :suggestion, :risk_level, :inventory_date,
                                        :inventory_done_by, :contact_address, :note,
                                        equipment_attributes: [:id, :organization_unit_id, :inventory_number, :equipment_name_id, :model, :serial_number,:status_id,
                                                               :trained_end_users, :trained_maintenance_personnel, :tag_number,
                                                               :years_used, :equipment_risk_classification, :_destroy])
    end
end
