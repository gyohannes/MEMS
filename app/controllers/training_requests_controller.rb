class TrainingRequestsController < ApplicationController
  before_action :set_training_request, only: [:show, :edit, :update, :destroy]

  # GET /training_requests
  # GET /training_requests.json
  def index
    @training_requests = TrainingRequest.all
  end

  # GET /training_requests/1
  # GET /training_requests/1.json
  def show
  end

  # GET /training_requests/new
  def new
    @training_request = TrainingRequest.new
  end

  # GET /training_requests/1/edit
  def edit
  end

  # POST /training_requests
  # POST /training_requests.json
  def create
    @training_request = TrainingRequest.new(training_request_params)

    respond_to do |format|
      if @training_request.save
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
      params.require(:training_request).permit(:organization_structure_id, :facility_id, :trainee_type, :training_description, :requested_to, :request_to_org_structure, :request_to_facility, :request_to_institution, :requested_by, :request_date)
    end
end
