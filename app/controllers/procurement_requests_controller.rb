class ProcurementRequestsController < ApplicationController
  before_action :set_procurement_request, only: [:show, :edit, :update, :destroy]
  before_action :load

  def load
    @organization_structures = [current_user.organization_structure]
    @facilities = [current_user.facility]
    @user = [current_user]
  end
  # GET /procurement_requests
  # GET /procurement_requests.json
  def index
    @procurement_requests = ProcurementRequest.all
  end

  # GET /procurement_requests/1
  # GET /procurement_requests/1.json
  def show
  end

  # GET /procurement_requests/new
  def new
    @procurement_request = ProcurementRequest.new
    @procurement_request.organization_structure_id = current_user.organization_structure
    @procurement_request.facility = current_user.facility
  end

  # GET /procurement_requests/1/edit
  def edit
  end

  # POST /procurement_requests
  # POST /procurement_requests.json
  def create
    @procurement_request = ProcurementRequest.new(procurement_request_params)

    respond_to do |format|
      if @procurement_request.save
        format.html { redirect_to @procurement_request, notice: 'Procurement request was successfully created.' }
        format.json { render :show, status: :created, location: @procurement_request }
      else
        format.html { render :new }
        format.json { render json: @procurement_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procurement_requests/1
  # PATCH/PUT /procurement_requests/1.json
  def update
    respond_to do |format|
      if @procurement_request.update(procurement_request_params)
        format.html { redirect_to @procurement_request, notice: 'Procurement request was successfully updated.' }
        format.json { render :show, status: :ok, location: @procurement_request }
      else
        format.html { render :edit }
        format.json { render json: @procurement_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /procurement_requests/1
  # DELETE /procurement_requests/1.json
  def destroy
    @procurement_request.destroy
    respond_to do |format|
      format.html { redirect_to procurement_requests_url, notice: 'Procurement request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procurement_request
      @procurement_request = ProcurementRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procurement_request_params
      params.require(:procurement_request).permit(:organization_structure_id, :facility_id, :user_id, :contact_phone, :contact_email, :request_to,
      procurement_request_equipments_attributes: [:id, :equipment_name, :specification, :quanitity, :approved_quantity, :_destroy])
    end
end
