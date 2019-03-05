class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]

  # GET /inventories
  # GET /inventories.json
  def index
    @inventories = current_user.organization_structure ? current_user.organization_structure.sub_inventories :
                       (current_user.facility ? current_user.facility.inventories : [])
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
  end

  # GET /inventories/new
  def new
    @inventory = Inventory.new
    equipment = Equipment.find_by(id: params[:equipment])
    @inventory.equipment = equipment || Equipment.new
    session[:return_to] = request.referer
  end

  # GET /inventories/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /inventories
  # POST /inventories.json
  def create
    equipment = Equipment.find_by(facility_id: params[:inventory][:equipment_attributes][:facility_id],
                                  inventory_number: params[:inventory][:equipment_attributes][:inventory_number],
                                  equipment_name: params[:inventory][:equipment_attributes][:equipment_name])

    unless equipment.blank?
      params[:inventory][:equipment_id] = equipment.id
      params[:inventory][:trained_end_users] = equipment.trained_end_users
      params[:inventory][:trained_maintenance_personnel] = equipment.trained_maintenance_personnel
    end
    params[:inventory].delete('equipment_attributes')
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        equipment.update(status: @inventory.status)
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
    equipment = Equipment.find_by(facility_id: params[:inventory][:equipment_attributes][:facility_id],
                                  inventory_number: params[:inventory][:equipment_attributes][:inventory_number],
                                  equipment_name: params[:inventory][:equipment_attributes][:equipment_name])

    unless equipment.blank?
      params[:inventory][:equipment_id] = equipment.id
      params[:inventory][:trained_end_users] = equipment.trained_end_users
      params[:inventory][:trained_maintenance_personnel] = equipment.trained_maintenance_personnel
    end
    params[:inventory].delete('equipment_attributes')

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
      params.require(:inventory).permit(:equipment_id, :status, :description_of_problem, :trained_end_users,
                                        :trained_maintenance_personnel, :suggestion, :risk_level, :inventory_date,
                                        :inventory_done_by, :contact_address, :note,
                                        equipment_attributes: [:id, :facility_id, :equipment_name, :model, :serial_number,:status,
                                                               :trained_end_users, :trained_maintenance_personnel, :tag_number, :_destroy])
    end
end
