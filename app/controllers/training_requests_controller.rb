class TrainingRequestsController < ApplicationController
  before_action :set_training_request, only: [:show, :edit, :update, :destroy]

  # GET /training_requests
  # GET /training_requests.json
  def index
    if current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @training_requests = current_user.training_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @training_requests = current_user.incoming_training_requests
    elsif !current_user.institution.blank?
      @training_requests = current_user.incoming_training_requests
    else
      @training_requests = []
    end
  end

  # GET /training_requests/1
  # GET /training_requests/1.json
  def show
  end

  # GET /training_requests/new
  def new
    @training_request = TrainingRequest.new
  end

  def load_request_to
    @request_to_type = params[:request_to]
    @institutions = Institution.where('category = ?', @request_to_type)
    render partial: 'request_to'
  end

  def decision
    @training_request.update(procurement_request_params)
    redirect_to @training_request, notice: "Training request was successfully #{params[:status]}."
  end

  # GET /training_requests/1/edit
  def edit
    @request_to_type = @training_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
  end

  # POST /training_requests
  # POST /training_requests.json
  def create
    @training_request = TrainingRequest.new(training_request_params)
    @request_to_type = @training_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @training_request.save
        @training_request.update(status: Constants::PENDING)
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
    @request_to_type = @training_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
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
      params.require(:training_request).permit(:organization_structure_id, :facility_id, :trainee_type, :training_description, :request_to, :institution_id, :requested_by, :request_date)
    end
end
