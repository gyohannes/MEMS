class ProcurementRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_procurement_request, only: [:show, :edit, :update, :destroy, :decision]
  before_action :load

  def load
    @organization_structures = [current_user.try(:organization_structure)]
    @facilities = [current_user.try(:facility)]
    @user = [current_user]
  end
  # GET /procurement_requests
  # GET /procurement_requests.json
  def index
    if current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @procurement_requests = current_user.procurement_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @procurement_requests = current_user.incoming_procurement_requests
    elsif !current_user.institution.blank?
      @procurement_requests = current_user.incoming_procurement_requests
    else
      @procurement_requests = []
    end
  end

  def decision
      @procurement_request.update(procurement_request_params)
      if @procurement_request.errors.blank?
      @procurement_request.update(status: params[:status])
      if params[:status] == Constants::REJECTED
        @procurement_request.procurement_request_equipments.each do |pe|
          pe.update(approved_quantity: nil)
          pe.save
        end
      end
      redirect_to @procurement_request, notice: "Procurement request was successfully #{params[:status]}."
    else
      render 'show'
    end
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
    @procurement_request.procurement_request_equipments.build
  end

  def load_request_to
    @request_to_type = params[:request_to]
    @institutions = Institution.where('category = ?', @request_to_type)
    render partial: 'request_to'
  end
  # GET /procurement_requests/1/edit
  def edit
    @request_to_type = @procurement_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
  end

  # POST /procurement_requests
  # POST /procurement_requests.json
  def create
    @procurement_request = ProcurementRequest.new(procurement_request_params)
    @request_to_type = @procurement_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @procurement_request.save
        @procurement_request.update(status: Constants::PENDING)
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
    @request_to_type = @procurement_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    @procurement_request.institution_id = params[:procurement_request][:institution_id]
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
      params.require(:procurement_request).permit(:organization_structure_id, :facility_id, :user_id, :contact_phone, :contact_email,
                                                  :request_date, :request_to, :institution_id, :comment, :decision_by,
      procurement_request_equipments_attributes: [:id, :equipment_name, :specification, :quantity, :approved_quantity, :_destroy])
    end
end
