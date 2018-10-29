class SpecificationRequestsController < ApplicationController
  before_action :set_specification_request, only: [:show, :edit, :update, :destroy]


  def load
  end
  # GET /specification_requests
  # GET /specification_requests.json
  def index
    @specification_requests = SpecificationRequest.all
  end

  # GET /specification_requests/1
  # GET /specification_requests/1.json
  def show
  end

  # GET /specification_requests/new
  def new
    @specification_request = SpecificationRequest.new
  end

  # GET /specification_requests/1/edit
  def edit
  end

  # POST /specification_requests
  # POST /specification_requests.json
  def create
    @specification_request = SpecificationRequest.new(specification_request_params)

    respond_to do |format|
      if @specification_request.save
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
      params.require(:specification_request).permit(:organization_structure_id, :facility_id, :requested_to, :requested_to_org_structure, :requested_to_facility, :requested_to_institution, :equipment_name, :quantity, :requested_by, :requested_date)
    end
end
