class AcceptanceRequestsController < ApplicationController
  before_action :set_acceptance_request, only: [:show, :edit, :update, :destroy]

  # GET /acceptance_requests
  # GET /acceptance_requests.json
  def index
    @acceptance_requests = AcceptanceRequest.all
  end

  # GET /acceptance_requests/1
  # GET /acceptance_requests/1.json
  def show
  end

  # GET /acceptance_requests/new
  def new
    @acceptance_request = AcceptanceRequest.new
  end

  def load_request_to
    @request_to_type = params[:request_to]
    @institutions = Institution.where('category = ?', @request_to_type)
    render partial: 'request_to'
  end

  def decision
    @acceptance_request.update(procurement_request_params)
    redirect_to @acceptance_requests, notice: "Acceptance request was successfully #{params[:status]}."
  end


  # GET /acceptance_requests/1/edit
  def edit
    @request_to_type = @acceptance_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
  end

  # POST /acceptance_requests
  # POST /acceptance_requests.json
  def create
    @acceptance_request = AcceptanceRequest.new(acceptance_request_params)
    @request_to_type = @acceptance_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @acceptance_request.save
        @acceptance_request.update(status: Constants::PENDING)
        format.html { redirect_to @acceptance_request, notice: 'Acceptance request was successfully created.' }
        format.json { render :show, status: :created, location: @acceptance_request }
      else
        format.html { render :new }
        format.json { render json: @acceptance_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acceptance_requests/1
  # PATCH/PUT /acceptance_requests/1.json
  def update
    @request_to_type = @acceptance_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @acceptance_request.update(acceptance_request_params)
        format.html { redirect_to @acceptance_request, notice: 'Acceptance request was successfully updated.' }
        format.json { render :show, status: :ok, location: @acceptance_request }
      else
        format.html { render :edit }
        format.json { render json: @acceptance_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acceptance_requests/1
  # DELETE /acceptance_requests/1.json
  def destroy
    @acceptance_request.destroy
    respond_to do |format|
      format.html { redirect_to acceptance_requests_url, notice: 'Acceptance request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acceptance_request
      @acceptance_request = AcceptanceRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acceptance_request_params
      params.require(:acceptance_request).permit(:organization_structure_id, :facility_id, :equipment_name, :model, :volts_ampere, :power_requirement, :description, :request_to, :institution_id, :requested_by, :request_date)
    end
end
