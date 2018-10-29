class MaintenanceToolkitRequestsController < ApplicationController
  before_action :set_maintenance_toolkit_request, only: [:show, :edit, :update, :destroy]

  # GET /maintenance_toolkit_requests
  # GET /maintenance_toolkit_requests.json
  def index
    @maintenance_toolkit_requests = MaintenanceToolkitRequest.all
  end

  # GET /maintenance_toolkit_requests/1
  # GET /maintenance_toolkit_requests/1.json
  def show
  end

  # GET /maintenance_toolkit_requests/new
  def new
    @maintenance_toolkit_request = MaintenanceToolkitRequest.new
  end

  # GET /maintenance_toolkit_requests/1/edit
  def edit
  end

  # POST /maintenance_toolkit_requests
  # POST /maintenance_toolkit_requests.json
  def create
    @maintenance_toolkit_request = MaintenanceToolkitRequest.new(maintenance_toolkit_request_params)

    respond_to do |format|
      if @maintenance_toolkit_request.save
        format.html { redirect_to @maintenance_toolkit_request, notice: 'Maintenance toolkit request was successfully created.' }
        format.json { render :show, status: :created, location: @maintenance_toolkit_request }
      else
        format.html { render :new }
        format.json { render json: @maintenance_toolkit_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenance_toolkit_requests/1
  # PATCH/PUT /maintenance_toolkit_requests/1.json
  def update
    respond_to do |format|
      if @maintenance_toolkit_request.update(maintenance_toolkit_request_params)
        format.html { redirect_to @maintenance_toolkit_request, notice: 'Maintenance toolkit request was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintenance_toolkit_request }
      else
        format.html { render :edit }
        format.json { render json: @maintenance_toolkit_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_toolkit_requests/1
  # DELETE /maintenance_toolkit_requests/1.json
  def destroy
    @maintenance_toolkit_request.destroy
    respond_to do |format|
      format.html { redirect_to maintenance_toolkit_requests_url, notice: 'Maintenance toolkit request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_toolkit_request
      @maintenance_toolkit_request = MaintenanceToolkitRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintenance_toolkit_request_params
      params.require(:maintenance_toolkit_request).permit(:organization_structure_id, :facility_id, :toolkit_name, :toolkit_description, :quantity, :requested_to, :request_to_org_structure, :request_to_facility, :requested_by, :contact_address, :request_date)
    end
end
