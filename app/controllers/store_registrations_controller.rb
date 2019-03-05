class StoreRegistrationsController < ApplicationController
  before_action :set_store_registration, only: [:show, :edit, :update, :destroy]

  # GET /store_registrations
  # GET /store_registrations.json
  def index
    @store_registrations = []
    if current_user.facility
      @store_registrations = current_user.facility.store_registrations
    elsif current_user.organization_structure
      @store_registrations = current_user.organization_structure.store_registrations
    end
    return @store_registrations
  end

  # GET /store_registrations/1
  # GET /store_registrations/1.json
  def show
  end

  # GET /store_registrations/new
  def new
    @store_registration = StoreRegistration.new
    @store_registration.store = current_user.try(:store)
    @store_registration.build_equipment
  end

  # GET /store_registrations/1/edit
  def edit
  end

  # POST /store_registrations
  # POST /store_registrations.json
  def create
    equipment = Equipment.find_by(facility_id: params[:store_registration][:equipment_attributes][:facility_id],
                                  inventory_number: params[:store_registration][:equipment_attributes][:inventory_number],
                                  equipment_name: params[:store_registration][:equipment_attributes][:equipment_name])

    unless equipment.blank?
      params[:store_registration][:equipment_id] = equipment.id
      params[:store_registration].delete('equipment_attributes')
    end
    @store_registration = StoreRegistration.new(store_registration_params)

    respond_to do |format|
      if @store_registration.save
        @store_registration.equipment.update(status: Equipment::IN_STORE)
        format.html { redirect_to @store_registration, notice: 'Store registration was successfully created.' }
        format.json { render :show, status: :created, location: @store_registration }
      else
        format.html { render :new }
        format.json { render json: @store_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /store_registrations/1
  # PATCH/PUT /store_registrations/1.json
  def update
    equipment = Equipment.find_by(facility_id: params[:store_registration][:equipment_attributes][:facility_id],
                                  inventory_number: params[:store_registration][:equipment_attributes][:inventory_number],
                                  equipment_name: params[:store_registration][:equipment_attributes][:equipment_name])

    unless equipment.blank?
      params[:store_registration][:equipment_id] = equipment.id
      params[:store_registration].delete('equipment_attributes')
    end

    respond_to do |format|
      if @store_registration.update(store_registration_params)
        @store_registration.equipment.update(status: Equipment::IN_STORE)
        format.html { redirect_to @store_registration, notice: 'Store registration was successfully updated.' }
        format.json { render :show, status: :ok, location: @store_registration }
      else
        format.html { render :edit }
        format.json { render json: @store_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_registrations/1
  # DELETE /store_registrations/1.json
  def destroy
    @store_registration.destroy
    respond_to do |format|
      format.html { redirect_to store_registrations_url, notice: 'Store registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_registration
      @store_registration = StoreRegistration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_registration_params
      params.require(:store_registration).permit(:store_id, :equipment_id, :been_number, equipment_attributes: [:id, :facility_id, :status, :equipment_name, :model, :serial_number, :tag_number, :_destroy])
    end
end
