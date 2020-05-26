class InstallationRequestsController < ApplicationController
  before_action :set_installation_request, only: [:show, :edit, :update, :destroy, :decision]
  before_action :load

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Installation Requests", :installation_requests_path

  def load
    @engineers = current_user.load_users(Constants::BIOMEDICAL_ENGINEER)
    @actions = current_user.parent_org_unit ? Constants::ACTIONS : Constants::ACTIONS.reject{|x| x == Constants::FORWARDED}
    @organization_units = [current_user.parent_org_unit]
    @institutions = Institution.all
  end
  # GET /installation_requests
  # GET /installation_requests.json
  def index
    if current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @installation_requests = current_user.installation_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @installation_requests = current_user.outgoing_installation_requests + current_user.incoming_installation_requests
    elsif !current_user.institution.blank?
      @installation_requests = current_user.incoming_installation_requests
    else
      @installation_requests = []
    end
  end

  # GET /installation_requests/1
  # GET /installation_requests/1.json
  def show
    add_breadcrumb "Details", :installation_request_path

    @installation_request.forwards.build(organization_unit_id: current_user.parent_org_unit.try(:id))
  end

  # GET /installation_requests/new
  def new
    add_breadcrumb "New", :new_installation_request_path
    @installation_request = InstallationRequest.new
  end

  def decision
    @installation_request.update(installation_request_params)
    if @installation_request.status == Constants::FORWARDED
      n = @installation_request.notifications.build(name: @installation_request.equipment_name.to_s << ' Installation Request Forwarded',
                                                     organization_unit_id: current_user.parent_org_unit.try(:id))
      n.save
    end
    redirect_to @installation_request, notice: "Installation request was successfully #{params[:installation_request][:status]}."
  end


  # GET /installation_requests/1/edit
  def edit
    add_breadcrumb "Edit", :edit_installation_request_path
  end

  # POST /installation_requests
  # POST /installation_requests.json
  def create
    @installation_request = InstallationRequest.new(installation_request_params)
    @installation_request.organization_unit_id = current_user.department ? current_user.organization_unit_id : current_user.parent_org_unit.try(:id)
    @installation_request.status = Constants::PENDING
    respond_to do |format|
      if @installation_request.save
        n = @installation_request.notifications.build(name: @installation_request.equipment_name.to_s << ' Installation Request',
                                                       organization_unit_id: @installation_request.organization_unit_id)
        n.save
        format.html { redirect_to @installation_request, notice: 'Installation request was successfully created.' }
        format.json { render :show, status: :created, location: @installation_request }
      else
        format.html { render :new }
        format.json { render json: @installation_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /installation_requests/1
  # PATCH/PUT /installation_requests/1.json
  def update
    respond_to do |format|
      if @installation_request.update(installation_request_params)
        format.html { redirect_to @installation_request, notice: 'Installation request was successfully updated.' }
        format.json { render :show, status: :ok, location: @installation_request }
      else
        format.html { render :edit }
        format.json { render json: @installation_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /installation_requests/1
  # DELETE /installation_requests/1.json
  def destroy
    @installation_request.destroy
    respond_to do |format|
      format.html { redirect_to installation_requests_url, notice: 'Installation request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_installation_request
      @installation_request = InstallationRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def installation_request_params
      params.require(:installation_request).permit(:organization_unit_id, :equipment_name_id, :model, :description, :attachment,
                                                  :status, :user_id, :request_date, :comment, :decision_by, :assigned_to,
                                                   forwards_attributes: [:id, :forwardable_id, :institution_id, :organization_unit_id, :_destroy])
    end
end
