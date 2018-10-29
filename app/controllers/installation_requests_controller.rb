class InstallationRequestsController < ApplicationController
  before_action :set_installation_request, only: [:show, :edit, :update, :destroy]

  # GET /installation_requests
  # GET /installation_requests.json
  def index
    @installation_requests = InstallationRequest.all
  end

  # GET /installation_requests/1
  # GET /installation_requests/1.json
  def show
  end

  # GET /installation_requests/new
  def new
    @installation_request = InstallationRequest.new
  end

  # GET /installation_requests/1/edit
  def edit
  end

  # POST /installation_requests
  # POST /installation_requests.json
  def create
    @installation_request = InstallationRequest.new(installation_request_params)

    respond_to do |format|
      if @installation_request.save
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
      params.require(:installation_request).permit(:organization_structure_id, :facility_id, :equipment_name, :model, :installation_description, :requested_to, :request_to_org_structure, :request_to_facility, :request_to_institution, :requested_by, :request_date)
    end
end
