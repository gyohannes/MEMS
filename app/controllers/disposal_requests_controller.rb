class DisposalRequestsController < ApplicationController
  before_action :set_disposal_request, only: [:show, :edit, :update, :destroy]

  # GET /disposal_requests
  # GET /disposal_requests.json
  def index
    @disposal_requests = DisposalRequest.all
  end

  # GET /disposal_requests/1
  # GET /disposal_requests/1.json
  def show
  end

  # GET /disposal_requests/new
  def new
    @disposal_request = DisposalRequest.new
  end

  def load_request_to
    @request_to_type = params[:request_to]
    @institutions = Institution.where('category = ?', @request_to_type)
    render partial: 'request_to'
  end

  def decision
    @disposal_request.update(procurement_request_params)
    redirect_to @disposal_request, notice: "Disposal request was successfully #{params[:status]}."
  end


  # GET /disposal_requests/1/edit
  def edit
    @request_to_type = @disposal_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
  end

  # POST /disposal_requests
  # POST /disposal_requests.json
  def create
    @disposal_request = DisposalRequest.new(disposal_request_params)
    @request_to_type = @disposal_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @disposal_request.save
        @disposal_request.update(status: Constants::PENDING)
        format.html { redirect_to @disposal_request, notice: 'Disposal request was successfully created.' }
        format.json { render :show, status: :created, location: @disposal_request }
      else
        format.html { render :new }
        format.json { render json: @disposal_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disposal_requests/1
  # PATCH/PUT /disposal_requests/1.json
  def update
    @request_to_type = @disposal_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @disposal_request.update(disposal_request_params)
        format.html { redirect_to @disposal_request, notice: 'Disposal request was successfully updated.' }
        format.json { render :show, status: :ok, location: @disposal_request }
      else
        format.html { render :edit }
        format.json { render json: @disposal_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disposal_requests/1
  # DELETE /disposal_requests/1.json
  def destroy
    @disposal_request.destroy
    respond_to do |format|
      format.html { redirect_to disposal_requests_url, notice: 'Disposal request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disposal_request
      @disposal_request = DisposalRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disposal_request_params
      params.require(:disposal_request).permit(:organization_structure_id, :facility_id, :equipment_id, :disposal_description, :request_to, :contact_address, :requested_by, :request_date)
    end
end
