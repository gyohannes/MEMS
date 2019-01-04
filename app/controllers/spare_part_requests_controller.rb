class SparePartRequestsController < ApplicationController
  before_action :set_spare_part_request, only: [:show, :edit, :update, :destroy]

  # GET /spare_part_requests
  # GET /spare_part_requests.json
  def index
    @spare_part_requests = SparePartRequest.all
  end

  # GET /spare_part_requests/1
  # GET /spare_part_requests/1.json
  def show
  end

  # GET /spare_part_requests/new
  def new
    @spare_part_request = SparePartRequest.new
  end

  def load_request_to
    @request_to_type = params[:request_to]
    @institutions = Institution.where('category = ?', @request_to_type)
    render partial: 'request_to'
  end

  def decision
    @spare_part_request.update(procurement_request_params)
    redirect_to @spare_part_request, notice: "Spare Part request was successfully #{params[:status]}."
  end

  # GET /spare_part_requests/1/edit
  def edit
    @request_to_type = @spare_part_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
  end

  # POST /spare_part_requests
  # POST /spare_part_requests.json
  def create
    @spare_part_request = SparePartRequest.new(spare_part_request_params)
    @request_to_type = @spare_part_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @spare_part_request.save
        @spare_part_request.update(status: Constants::PENDING)
        format.html { redirect_to @spare_part_request, notice: 'Spare part request was successfully created.' }
        format.json { render :show, status: :created, location: @spare_part_request }
      else
        format.html { render :new }
        format.json { render json: @spare_part_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spare_part_requests/1
  # PATCH/PUT /spare_part_requests/1.json
  def update
    @request_to_type = @spare_part_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @spare_part_request.update(spare_part_request_params)
        @spare_part_request.update(status: Constants::PENDING)
        format.html { redirect_to @spare_part_request, notice: 'Spare part request was successfully updated.' }
        format.json { render :show, status: :ok, location: @spare_part_request }
      else
        format.html { render :edit }
        format.json { render json: @spare_part_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spare_part_requests/1
  # DELETE /spare_part_requests/1.json
  def destroy
    @spare_part_request.destroy
    respond_to do |format|
      format.html { redirect_to spare_part_requests_url, notice: 'Spare part request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spare_part_request
      @spare_part_request = SparePartRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spare_part_request_params
      params.require(:spare_part_request).permit(:organization_structure_id, :facility_id, :spare_part_name, :model, :volts_ampere, :power_requirement, :quantity, :request_to, :institution_id, :requested_by, :request_date)
    end
end
