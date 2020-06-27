class SpecificationRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_specification_request, only: [:show, :edit, :update, :destroy, :decision]
  before_action :load

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Specification Requests", :specification_requests_path

  def load
    @engineers = current_user.load_users(Constants::BIOMEDICAL_ENGINEER)
    @actions = current_user.parent_org_unit ? Constants::ACTIONS : Constants::ACTIONS.reject{|x| x == Constants::FORWARDED}
    @organization_units = [current_user.parent_org_unit]
    @institutions = Institution.all
  end

  # GET /specification_requests
  # GET /specification_requests.json
  def index
    if current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @specification_requests = current_user.specification_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      (@specification_requests = current_user.outgoing_specification_requests + current_user.incoming_specification_requests).uniq
    elsif !current_user.institution.blank?
      @specification_requests = current_user.incoming_specification_requests
    else
      @specification_requests = []
    end
  end

  # GET /specification_requests/1
  # GET /specification_requests/1.json
  def show
    add_breadcrumb "Details", :specification_request_path
    @specification_request.forwards.build(organization_unit_id: current_user.parent_org_unit.try(:id))
  end

  # GET /specification_requests/new
  def new
    add_breadcrumb "New", :new_specification_request_path
    @specification_request = SpecificationRequest.new
  end

  def decision
    @specification_request.update(specification_request_params)
    if @specification_request.status == Constants::FORWARDED
      n = @specification_request.notifications.build(name: @specification_request.equipment_name.to_s << ' Specification Request Forwarded',
                                                   organization_unit_id: current_user.parent_org_unit.try(:id))
      n.save
    end
    redirect_to @specification_request, notice: "Specification request was successfully #{params[:specification_request][:status]}."
  end

  # GET /specification_requests/1/edit
  def edit
    add_breadcrumb "Edit", :edit_specification_request_path
  end

  # POST /specification_requests
  # POST /specification_requests.json
  def create
    @specification_request = SpecificationRequest.new(specification_request_params)
    @specification_request.organization_unit_id = (current_user.is_role(Constants::BIOMEDICAL_ENGINEER) or current_user.is_role(Constants::DEPARTMENT)) ? current_user.organization_unit_id : current_user.parent_org_unit.try(:id)
    @specification_request.status = Constants::PENDING
    respond_to do |format|
      if @specification_request.save
        n = @specification_request.notifications.build(name: @specification_request.equipment_name.to_s << ' Specification Request',
                                                     organization_unit_id: @specification_request.organization_unit_id)
        n.save
        format.html { redirect_to @specification_request, notice: 'Specification request was successfully created.' }
        format.json { render :show, status: :created, location: @specification_request }
      else
        format.html { render :new }
        format.json { render json: @specification_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /specification_requests/1
  # PATCH/PUT /specification_requests/1.json
  def update
    @request_to_type = @specification_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @specification_request.update(specification_request_params)
        format.html { redirect_to @specification_request, notice: 'Specification request was successfully updated.' }
        format.json { render :show, status: :ok, location: @specification_request }
      else
        format.html { render :edit }
        format.json { render json: @specification_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specification_requests/1
  # DELETE /specification_requests/1.json
  def destroy
    @specification_request.destroy
    respond_to do |format|
      format.html { redirect_to specification_requests_url, notice: 'Specification request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_specification_request
      @specification_request = SpecificationRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def specification_request_params
      params.require(:specification_request).permit(:organization_unit_id, :equipment_name_id, :description, :attachment,
                                                    :user_id, :requested_date, :comment, :decision_by, :assigned_by, :status,
                                                    forwards_attributes: [:id, :forwardable_id, :institution_id, :organization_unit_id, :_destroy])
    end
end
