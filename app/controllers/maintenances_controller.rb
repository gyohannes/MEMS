class MaintenancesController < ApplicationController
  before_action :set_maintenance, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update, :index]

  def load
    @equipments = current_user.load_equipment
    @maintenance_requests = current_user.incoming_maintenance_requests.where('status in (?)',[Constants::PENDING, Constants::APPROVED])
  end

  def load_maintenance_requests
    maintenance_request = MaintenanceRequest.find_by(id: params[:maintenance_request])
    @equipments = maintenance_request.equipment
    render partial: 'equipment'
  end

  # GET /installations
  # GET /installations.json
  def index
    @maintenances = Maintenance.joins(:equipment).where('equipment_id in (?)', @equipments.pluck(:id))
  end

  # GET /maintenances/1
  # GET /maintenances/1.json
  def show
  end

  # GET /maintenances/new
  def new
    @maintenance = Maintenance.new
    @maintenance.equipment_id = params[:equipment]
    @maintenance.maintenance_request_id = params[:maintenance_request]
    @maintenance.maintenance_work_order_id = params[:work_order]
    session[:return_to] = request.referer
  end

  # GET /maintenances/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /maintenances
  # POST /maintenances.json
  def create
    @maintenance = Maintenance.new(maintenance_params)
    @maintenance.user_id = current_user.id
    respond_to do |format|
      if @maintenance.save
        unless @maintenance.maintenance_work_order.blank?
          mwo = @maintenance.maintenance_work_order
          mwo.update_attribute('status', Constants::COMPLETED)
        end
        unless @maintenance.maintenance_request.blank?
          mr = @maintenance.maintenance_request
          mr.update_attribute('status', 'Maintenance Done')
        end
        @maintenance.equipment.update_attribute('status_id', @maintenance.status_id)
        format.html { redirect_to session.delete(:return_to), notice: 'Maintenance was successfully created.' }
        format.json { render :show, status: :created, location: @maintenance }
      else
        format.html { render :new }
        format.json { render json: @maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenances/1
  # PATCH/PUT /maintenances/1.json
  def update
    @maintenance.user_id = current_user.id
    respond_to do |format|
      if @maintenance.update(maintenance_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Maintenance was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintenance }
      else
        format.html { render :edit }
        format.json { render json: @maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenances/1
  # DELETE /maintenances/1.json
  def destroy
    @maintenance.destroy
    respond_to do |format|
      format.html { redirect_to maintenances_url, notice: 'Maintenance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance
      @maintenance = Maintenance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintenance_params
      params.require(:maintenance).permit(:equipment_id, :maintenance_work_order_id, :description_of_equipment_failure, :cause_of_equipment_failure,
                                          :maintenance_request_id, :status_id, :part_of_equipment_maintained, :corrective_action, :spare_parts_used,
                                          :start_date, :end_date, :maintenance_cost, :engineer_name_and_contact, :maintenance_type, :note)
    end
end
