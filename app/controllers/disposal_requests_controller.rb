class DisposalRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_disposal_request, only: [:show, :edit, :update, :destroy, :decision]
  before_action :load
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Disposal Requests", :disposal_requests_path

  def load
    @equipments = current_user.load_equipment
    @actions = current_user.parent_org_unit ? Constants::ACTIONS : Constants::ACTIONS.reject{|x| x == Constants::FORWARDED}
    @organization_units = [current_user.parent_org_unit]
    @institutions = Institution.all
  end
  # GET /disposal_requests
  # GET /disposal_requests.json
  def index
    if current_user.is_role(Constants::DEPARTMENT)
      @disposal_requests = current_user.disposal_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @disposal_requests = current_user.disposal_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @disposal_requests = current_user.outgoing_disposal_requests + current_user.incoming_disposal_requests
    else
      @disposal_requests = []
    end
  end

  # GET /disposal_requests/1
  # GET /disposal_requests/1.json
  def show
    add_breadcrumb "Details", :disposal_request_path

    @disposal_request.forwards.build(organization_unit_id: current_user.parent_org_unit.try(:id))
  end

  # GET /disposal_requests/new
  def new
    add_breadcrumb "New", :new_disposal_request_path

    @disposal_request = DisposalRequest.new
  end

  def decision
    @disposal_request.update(disposal_request_params)
    if @disposal_request.status == Constants::FORWARDED
      n = @disposal_request.notifications.build(name: @disposal_request.equipment.to_s << ' Disposal Request Forwarded',
                                                   organization_unit_id: current_user.parent_org_unit.try(:id))
      n.save
    end
    redirect_to @disposal_request, notice: "Disposal request was successfully #{params[:disposal_request][:status]}."
  end


  # GET /disposal_requests/1/edit
  def edit
    add_breadcrumb "Edit", :edit_disposal_request_path
  end

  # POST /disposal_requests
  # POST /disposal_requests.json
  def create
    @disposal_request = DisposalRequest.new(disposal_request_params)
    @disposal_request.organization_unit_id = current_user.department ? current_user.organization_unit_id : current_user.parent_org_unit.try(:id)
    @disposal_request.status = Constants::PENDING
    respond_to do |format|
      if @disposal_request.save
        n = @disposal_request.notifications.build(name: @disposal_request.equipment.to_s << ' Disposal Request',
                                                     organization_unit_id: @disposal_request.organization_unit_id)
        n.save
        format.html { redirect_to @disposal_request, notice: 'Disposal request was successfully created.' }
        format.json { render :show, status: :created, location: @disposal_request }
      else
        format.html { render :new }
        format.json { render json: @disposal_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disposal_requests/1
  # PATCH/PUT /disposal_requests/1.json
  def update
    respond_to do |format|
      if @disposal_request.update(disposal_request_params)
        format.html { redirect_to @disposal_request, notice: 'Disposal request was successfully updated.' }
        format.json { render :show, status: :ok, location: @disposal_request }
      else
        format.html { render :edit }
        format.json { render json: @disposal_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disposal_requests/1
  # DELETE /disposal_requests/1.json
  def destroy
    @disposal_request.destroy
    respond_to do |format|
      format.html { redirect_to disposal_requests_url, notice: 'Disposal request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disposal_request
      @disposal_request = DisposalRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disposal_request_params
      params.require(:disposal_request).permit(:organization_unit_id, :equipment_id, :description, :attachment,
                                               :contact_address, :user_id, :request_date, :comment, :decision_by,
                                               forwards_attributes: [:id, :forwardable_id, :institution_id, :organization_unit_id, :_destroy])
    end
end
