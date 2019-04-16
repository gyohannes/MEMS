class InstallationRequestsController < ApplicationController
  before_action :set_installation_request, only: [:show, :edit, :update, :destroy, :decision]
  before_action :load, only: [:new, :create, :edit, :update, :show]

  def load
    @engineers = current_user.load_users(Constants::BIOMEDICAL_ENGINEER)
  end
  # GET /installation_requests
  # GET /installation_requests.json
  def index
    if current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @installation_requests = current_user.installation_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @installation_requests = current_user.installation_requests + current_user.incoming_installation_requests
    elsif !current_user.institution.blank?
      @installation_requests = current_user.incoming_installation_requests
    else
      @installation_requests = []
    end
  end

  # GET /installation_requests/1
  # GET /installation_requests/1.json
  def show
    @status = @installation_request.status
    @installation_request.status = Constants::PENDING if @status == Constants::FORWARDED
  end

  # GET /installation_requests/new
  def new
    @installation_request = InstallationRequest.new
  end

  def load_request_to
    @request_to_type = params[:request_to]
    @institutions = Institution.where('category = ?', @request_to_type)
    render partial: 'request_to'
  end

  def decision
    @installation_request.update(installation_request_params)
    @installation_request.update(status: params[:status])
    redirect_to @installation_request, notice: "Installation request was successfully #{params[:status]}."
  end


  # GET /installation_requests/1/edit
  def edit
    @request_to_type = @installation_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
  end

  # POST /installation_requests
  # POST /installation_requests.json
  def create
    @installation_request = InstallationRequest.new(installation_request_params)
    @request_to_type = @installation_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @installation_request.save
        @installation_request.update(status: Constants::PENDING)
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
    @request_to_type = @installation_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
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
      params.require(:installation_request).permit(:organization_structure_id, :facility_id, :equipment_name, :model, :installation_description,
                                                  :status, :request_to, :institution_id, :user_id, :request_date, :comment, :decision_by, :assigned_to)
    end
end
