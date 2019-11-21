class MaintenanceRequestsController < ApplicationController
  before_action :set_maintenance_request, only: [:show, :edit, :update, :destroy, :forward]
  before_action :load, only: [:new, :create, :edit, :update, :show]

  def load
    @equipments = current_user.load_equipment
    @engineers = current_user.load_users(Constants::BIOMEDICAL_ENGINEER)
  end
  # GET /maintenance_requests
  # GET /maintenance_requests.json
  def index
    if current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @maintenance_requests = current_user.maintenance_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @maintenance_requests = current_user.maintenance_requests + current_user.incoming_maintenance_requests
    elsif !current_user.institution.blank?
      @maintenance_requests = current_user.incoming_maintenance_requests
    else
      @maintenance_requests = []
    end
  end

  # GET /maintenance_requests/1
  # GET /maintenance_requests/1.json
  def show
    @status = @maintenance_request.status
    @maintenance_request.status = Constants::PENDING if @status == Constants::FORWARDED
  end

  # GET /maintenance_requests/new
  def new
    @maintenance_request = MaintenanceRequest.new
  end

  def load_request_to
    @request_to_type = params[:request_to]
    @institutions = Institution.where('category = ?', @request_to_type)
    render partial: 'request_to'
  end

  def forward
    @maintenance_request.update_attributes(status: Constants::FORWARDED, organization_unit_id: current_user.organization_unit.parent_organization_unit_id)
    n = @maintenance_request.notifications.build(name: @maintenance_request.equipment.to_s << ' Maintenance Request Forwarded',
                                                 organization_unit_id: current_user.organization_unit.parent_organization_unit_id)
    n.save
    redirect_to @maintenance_request, notice: "Maintenance request was successfully #{@maintenance_request.status}"
  end


  # GET /maintenance_requests/1/edit
  def edit
  end

  # POST /maintenance_requests
  # POST /maintenance_requests.json
  def create
    @maintenance_request = MaintenanceRequest.new(maintenance_request_params)
    @maintenance_request.request_status = Constants::PENDING
    equipment = @maintenance_request.equipment
    respond_to do |format|
      if @maintenance_request.save
        equipment.update_attribute('status_id', @maintenance_request.status_id)
        n = @maintenance_request.notifications.build(name: @maintenance_request.equipment.to_s << ' Maintenance Request',
                                                     organization_unit_id: current_user.organization_unit_id)
        n.save
        format.html { redirect_to @maintenance_request, notice: 'Maintenance request was successfully created.' }
        format.json { render :show, status: :created, location: @maintenance_request }
      else
        format.html { render :new }
        format.json { render json: @maintenance_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenance_requests/1
  # PATCH/PUT /maintenance_requests/1.json
  def update
    respond_to do |format|
      if @maintenance_request.update(maintenance_request_params)
        format.html { redirect_to @maintenance_request, notice: 'Maintenance request was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintenance_request }
      else
        format.html { render :edit }
        format.json { render json: @maintenance_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_requests/1
  # DELETE /maintenance_requests/1.json
  def destroy
    @maintenance_request.destroy
    respond_to do |format|
      format.html { redirect_to maintenance_requests_url, notice: 'Maintenance request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_request
      @maintenance_request = MaintenanceRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintenance_request_params
      params.require(:maintenance_request).permit(:organization_unit_id, :failure_date, :equipment_id, :description_of_problem, :status_id,
                                                  :institution_id, :user_id, :request_date, :comment, :request_status, :decision_by, :assigned_to )
    end
end
