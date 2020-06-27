class CalibrationRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_calibration_request, only: [:show, :edit, :update, :destroy, :decision]
  before_action :load

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Calibration Requests", :calibration_requests_path

  def load
    @equipments = current_user.load_equipment
    @engineers = current_user.load_users(Constants::BIOMEDICAL_ENGINEER)
    @actions = current_user.parent_org_unit ? Constants::ACTIONS : Constants::ACTIONS.reject{|x| x == Constants::FORWARDED}
    @organization_units = [current_user.parent_org_unit]
    @institutions = Institution.all
  end
  # GET /calibration_requests
  # GET /calibration_requests.json
  def index
    if current_user.is_role(Constants::DEPARTMENT)
      @calibration_requests = current_user.calibration_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @calibration_requests = current_user.calibration_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      (@calibration_requests = current_user.outgoing_calibration_requests + current_user.incoming_calibration_requests).uniq
    elsif !current_user.institution.blank?
      @calibration_requests = current_user.incoming_calibration_requests
    else
      @calibration_requests = []
    end
  end

  # GET /calibration_requests/1
  # GET /calibration_requests/1.json
  def show
    add_breadcrumb "Details", :calibration_request_path
    @calibration_request.forwards.build(organization_unit_id: current_user.parent_org_unit.try(:id))
  end

  # GET /calibration_requests/new
  def new
    add_breadcrumb "New", :new_calibration_request_path
    @calibration_request = CalibrationRequest.new
  end

  def decision
    @calibration_request.update(calibration_request_params)
    if @calibration_request.status == Constants::FORWARDED
      n = @calibration_request.notifications.build(name: @calibration_request.equipment.to_s << ' Calibration Request Forwarded',
                                                    organization_unit_id: current_user.parent_org_unit.try(:id))
      n.save
    end
    redirect_to @calibration_request, notice: "Calibration request was successfully #{params[:calibration_request][:status]}."
  end


  # GET /calibration_requests/1/edit
  def edit
    add_breadcrumb "Edit", :edit_calibration_request_path
  end

  # POST /calibration_requests
  # POST /calibration_requests.json
  def create
    @calibration_request = CalibrationRequest.new(calibration_request_params)
    @calibration_request.organization_unit_id = (current_user.is_role(Constants::BIOMEDICAL_ENGINEER) or current_user.is_role(Constants::DEPARTMENT)) ? current_user.organization_unit_id : current_user.parent_org_unit.try(:id)
    @calibration_request.status = Constants::PENDING
    respond_to do |format|
      if @calibration_request.save
        n = @calibration_request.notifications.build(name: @calibration_request.equipment.to_s << ' Calibration Request',
                                                      organization_unit_id: @calibration_request.organization_unit_id)
        n.save
        format.html { redirect_to @calibration_request, notice: 'Calibration request was successfully created.' }
        format.json { render :show, status: :created, location: @calibration_request }
      else
        format.html { render :new }
        format.json { render json: @calibration_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calibration_requests/1
  # PATCH/PUT /calibration_requests/1.json
  def update
    respond_to do |format|
      if @calibration_request.update(calibration_request_params)
        format.html { redirect_to @calibration_request, notice: 'Calibration request was successfully updated.' }
        format.json { render :show, status: :ok, location: @calibration_request }
      else
        format.html { render :edit }
        format.json { render json: @calibration_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calibration_requests/1
  # DELETE /calibration_requests/1.json
  def destroy
    @calibration_request.destroy
    respond_to do |format|
      format.html { redirect_to calibration_requests_url, notice: 'Calibration request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calibration_request
      @calibration_request = CalibrationRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calibration_request_params
      params.require(:calibration_request).permit(:organization_unit_id, :equipment_id, :description, :attachment,
                                                  :status, :institution_id, :user_id, :request_date, :comment, :decision_by, :assigned_to,
                                                  forwards_attributes: [:id, :forwardable_id, :institution_id, :organization_unit_id, :_destroy])
    end
end
