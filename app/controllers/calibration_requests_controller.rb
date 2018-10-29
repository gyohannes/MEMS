class CalibrationRequestsController < ApplicationController
  before_action :set_calibration_request, only: [:show, :edit, :update, :destroy]

  # GET /calibration_requests
  # GET /calibration_requests.json
  def index
    @calibration_requests = CalibrationRequest.all
  end

  # GET /calibration_requests/1
  # GET /calibration_requests/1.json
  def show
  end

  # GET /calibration_requests/new
  def new
    @calibration_request = CalibrationRequest.new
  end

  # GET /calibration_requests/1/edit
  def edit
  end

  # POST /calibration_requests
  # POST /calibration_requests.json
  def create
    @calibration_request = CalibrationRequest.new(calibration_request_params)

    respond_to do |format|
      if @calibration_request.save
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
      params.require(:calibration_request).permit(:organization_structure_id, :facility_id, :equipment_id, :calibration_description, :requested_to, :request_to_org_structure, :request_to_facility, :request_to_institution, :requested_by, :request_date)
    end
end
