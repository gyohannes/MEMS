class CalibrationRequestsController < ApplicationController
  before_action :set_calibration_request, only: [:show, :edit, :update, :destroy, :decision]
  before_action :load, only: [:new, :create, :edit, :update, :show]

  def load
    @equipments = current_user.load_equipment
    @engineers = current_user.load_users(Constants::BIOMEDICAL_ENGINEER)
  end
  # GET /calibration_requests
  # GET /calibration_requests.json
  def index
    if current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @calibration_requests = current_user.calibration_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @calibration_requests = current_user.calibration_requests + current_user.incoming_calibration_requests
    elsif !current_user.institution.blank?
      @calibration_requests = current_user.incoming_calibration_requests
    else
      @calibration_requests = []
    end
  end

  # GET /calibration_requests/1
  # GET /calibration_requests/1.json
  def show
    @status = @calibration_request.status
    @calibration_request = Constants::PENDING if @status==Constants::FORWARDED
  end

  # GET /calibration_requests/new
  def new
    @calibration_request = CalibrationRequest.new
  end

  def load_request_to
    @request_to_type = params[:request_to]
    @institutions = Institution.where('category = ?', @request_to_type)
    render partial: 'request_to'
  end

  def decision
    @calibration_request.update(calibration_request_params)
    @calibration_request.update(status: params[:status])
    redirect_to @calibration_request, notice: "Calibration request was successfully #{params[:status]}."
  end


  # GET /calibration_requests/1/edit
  def edit
    @request_to_type = @calibration_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
  end

  # POST /calibration_requests
  # POST /calibration_requests.json
  def create
    @calibration_request = CalibrationRequest.new(calibration_request_params)
    @request_to_type = @calibration_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @calibration_request.save
        @calibration_request.update(status: Constants::PENDING)
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
    @request_to_type = @calibration_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
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
      params.require(:calibration_request).permit(:organization_unit_id, :facility_id, :equipment_id, :calibration_description,
                                                  :status,:request_to, :institution_id, :user_id, :request_date, :comment, :decision_by, :assigned_to)
    end
end
