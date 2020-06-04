class TrainingRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_training_request, only: [:show, :edit, :update, :destroy, :decision]
  before_action :load, only: [:new, :create, :edit, :update, :show]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Training Requests", :training_requests_path

  def load
    @engineers = current_user.load_users(Constants::BIOMEDICAL_ENGINEER)
    @actions = current_user.parent_org_unit ? Constants::ACTIONS : Constants::ACTIONS.reject{|x| x == Constants::FORWARDED}
    @organization_units = [current_user.parent_org_unit]
    @institutions = Institution.all
  end
  # GET /training_requests
  # GET /training_requests.json
  def index
    if current_user.is_role(Constants::BIOMEDICAL_ENGINEER) or current_user.is_role(Constants::DEPARTMENT)
      @training_requests = current_user.training_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @training_requests = current_user.outgoing_training_requests + current_user.incoming_training_requests
    elsif !current_user.institution.blank?
      @training_requests = current_user.incoming_training_requests
    else
      @training_requests = []
    end
  end

  # GET /training_requests/1
  # GET /training_requests/1.json
  def show
    add_breadcrumb "Details", :training_request_path

    @training_request.forwards.build(organization_unit_id: current_user.parent_org_unit.try(:id))
    @status = @training_request.status
  end

  # GET /training_requests/new
  def new
    add_breadcrumb "New", :new_training_request_path

    @training_request = TrainingRequest.new
  end

  def decision
    @training_request.update(training_request_params)
    if @training_request.status == Constants::FORWARDED
      n = @training_request.notifications.build(name: @training_request.equipment_name.try(:to_s) << ' Training Request Forwarded',
                                                organization_unit_id: current_user.parent_org_unit.try(:id))
      n.save
    end
    redirect_to @training_request, notice: "Training request was successfully #{params[:training_request][:status]}."
  end

  # GET /training_requests/1/edit
  def edit
    add_breadcrumb "Edit", :edit_training_request_path
  end

  # POST /training_requests
  # POST /training_requests.json
  def create
    @training_request = TrainingRequest.new(training_request_params)
    @training_request.user_id = current_user.id
    @training_request.status = Constants::PENDING
    @training_request.organization_unit_id = current_user.department ? current_user.organization_unit_id : current_user.parent_org_unit.try(:id)
    respond_to do |format|
      if @training_request.save
        n = @training_request.notifications.build(name: @training_request.equipment_name.try(:to_s) << ' Training Request',
                                                     organization_unit_id: @training_request.organization_unit_id)
        n.save
        format.html { redirect_to @training_request, notice: 'Training request was successfully created.' }
        format.json { render :show, status: :created, location: @training_request }
      else
        format.html { render :new }
        format.json { render json: @training_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_requests/1
  # PATCH/PUT /training_requests/1.json
  def update
    respond_to do |format|
      if @training_request.update(training_request_params)
        format.html { redirect_to @training_request, notice: 'Training request was successfully updated.' }
        format.json { render :show, status: :ok, location: @training_request }
      else
        format.html { render :edit }
        format.json { render json: @training_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_requests/1
  # DELETE /training_requests/1.json
  def destroy
    @training_request.destroy
    respond_to do |format|
      format.html { redirect_to training_requests_url, notice: 'Training request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_request
      @training_request = TrainingRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_request_params
      params.require(:training_request).permit(:organization_unit_id, :equipment_name_id, :trainee_type, :level, :training_description, :attachment,
                                               :status, :user_id, :request_date, :comment, :decision_by, :assigned_to,
                                               forwards_attributes: [:id, :forwardable_id, :institution_id, :organization_unit_id, :_destroy])
    end
end
