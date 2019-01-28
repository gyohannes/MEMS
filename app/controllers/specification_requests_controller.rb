class SpecificationRequestsController < ApplicationController
  before_action :set_specification_request, only: [:show, :edit, :update, :destroy, :decision]


  def load
  end
  # GET /specification_requests
  # GET /specification_requests.json
  def index
    if current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @specification_requests = current_user.specification_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @specification_requests = current_user.incoming_specification_requests
    elsif !current_user.institution.blank?
      @specification_requests = current_user.incoming_specification_requests
    else
      @specification_requests = []
    end
  end

  # GET /specification_requests/1
  # GET /specification_requests/1.json
  def show
  end

  # GET /specification_requests/new
  def new
    @specification_request = SpecificationRequest.new
  end

  def load_request_to
    @request_to_type = params[:request_to]
    @institutions = Institution.where('category = ?', @request_to_type)
    render partial: 'request_to'
  end

  def decision
    @specification_request.update(specification_request_params)
    @specification_request.update(status: params[:status])
    redirect_to @specification_request, notice: "Specification request was successfully #{params[:status]}."
  end

  # GET /specification_requests/1/edit
  def edit
    @request_to_type = @specification_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
  end

  # POST /specification_requests
  # POST /specification_requests.json
  def create
    @specification_request = SpecificationRequest.new(specification_request_params)
    @request_to_type = @specification_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @specification_request.save
        @specification_request.update(status: Constants::PENDING)
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
    @request_to_type = @specification_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
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
      params.require(:specification_request).permit(:organization_structure_id, :facility_id, :request_to, :institution_id, :equipment_name, :quantity, :user_id, :requested_date, :comment, :decision_by)
    end
end
