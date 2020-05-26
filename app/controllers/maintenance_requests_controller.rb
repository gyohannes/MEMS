class MaintenanceRequestsController < ApplicationController
  before_action :set_maintenance_request, only: [:show, :edit, :update, :destroy, :decision]
  before_action :load, only: [:new, :create, :edit, :update, :show]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Maintenance Requests", :maintenance_requests_path

  def load
    @equipments = current_user.load_equipment
    @engineers = current_user.load_users(Constants::BIOMEDICAL_ENGINEER)
    @actions = current_user.parent_org_unit ? Constants::ACTIONS : Constants::ACTIONS.reject{|x| x == Constants::FORWARDED}
    @organization_units = [current_user.parent_org_unit]
  end
  # GET /maintenance_requests
  # GET /maintenance_requests.json
  def index
    if current_user.is_role(Constants::DEPARTMENT)
      @maintenance_requests = current_user.maintenance_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @maintenance_requests = current_user.maintenance_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @maintenance_requests = current_user.outgoing_maintenance_requests + current_user.incoming_maintenance_requests
    elsif !current_user.institution.blank?
      @maintenance_requests = current_user.incoming_maintenance_requests
    else
      @maintenance_requests = []
    end
  end

  # GET /maintenance_requests/1
  # GET /maintenance_requests/1.json
  def show
    add_breadcrumb "Details", :maintenance_request_path
    @maintenance_request.forwards.build(organization_unit_id: current_user.parent_org_unit.try(:id))
    @status = @maintenance_request.request_status
    @institutions = Institution.all
  end

  # GET /maintenance_requests/new
  def new
    add_breadcrumb "New", :new_maintenance_request_path
    @maintenance_request = MaintenanceRequest.new
  end

  def decision
    @maintenance_request.update(maintenance_request_params)
    if @maintenance_request.request_status == Constants::FORWARDED
      n = @maintenance_request.notifications.build(name: @maintenance_request.equipment.try(:to_s) << ' Maintenance Request Forwarded',
                                                organization_unit_id: current_user.parent_org_unit.try(:id))
      n.save
    end
    redirect_to @maintenance_request, notice: "Maintenance request was successfully #{params[:maintenance_request][:request_status]}."
  end


  # GET /maintenance_requests/1/edit
  def edit
    add_breadcrumb "Edit", :edit_maintenance_request_path
  end

  # POST /maintenance_requests
  # POST /maintenance_requests.json
  def create
    @maintenance_request = MaintenanceRequest.new(maintenance_request_params)
    @maintenance_request.request_status = Constants::REQUEST_PENDING
    @maintenance_request.organization_unit_id = current_user.department ? current_user.organization_unit_id : current_user.parent_org_unit.try(:id)
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
      params.require(:maintenance_request).permit(:organization_unit_id, :failure_date, :equipment_id, :attachment, :description_of_problem, :status_id,
                                                  :institution_id, :user_id, :request_date, :comment, :request_status, :decision_by, :assigned_to,
                                                  forwards_attributes: [:id, :forwardable_id, :institution_id, :organization_unit_id, :_destroy])
    end
end
