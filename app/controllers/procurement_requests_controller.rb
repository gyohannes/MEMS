class ProcurementRequestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_procurement_request, only: [:show, :edit, :update, :destroy, :decision]
  before_action :load

  def load
    @user = [current_user]
    @spare_parts = current_user.organization_unit.spare_parts
    @actions = current_user.parent_org_unit ? Constants::ACTIONS : Constants::ACTIONS.reject{|x| x == Constants::FORWARDED}
    @organization_units = [current_user.parent_org_unit]
    @institutions = Institution.all
  end
  # GET /procurement_requests
  # GET /procurement_requests.json
  def index
    if current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @procurement_requests = current_user.procurement_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @procurement_requests = current_user.outgoing_procurement_requests + current_user.incoming_procurement_requests
    elsif !current_user.institution.blank?
      @procurement_requests = current_user.incoming_procurement_requests
    else
      @procurement_requests = []
    end
  end

  def decision
      @procurement_request.update(procurement_request_params)
      if @procurement_request.status == Constants::FORWARDED
        n = @procurement_request.notifications.build(name: @procurement_request.user.organization_unit.try(:to_s) << ' Procurement Request Forwarded',
                                                  organization_unit_id: current_user.parent_org_unit.try(:id))
        n.save
      end
      redirect_to @procurement_request, notice: "Procurement request was successfully #{params[:procurement_request][:status]}."
  end

  # GET /procurement_requests/1
  # GET /procurement_requests/1.json
  def show
    @procurement_request.forwards.build(organization_unit_id: current_user.parent_org_unit.try(:id))
  end

  # GET /procurement_requests/new
  def new
    @procurement_request = ProcurementRequest.new
    @procurement_request.organization_unit_id = current_user.organization_unit
  end

  # GET /procurement_requests/1/edit
  def edit
  end

  # POST /procurement_requests
  # POST /procurement_requests.json
  def create
    @procurement_request = ProcurementRequest.new(procurement_request_params)
    @procurement_request.organization_unit_id = current_user.department or (current_user.is_role(Constants::BIOMEDICAL_ENGINEER)) ?
                                                                               current_user.organization_unit_id : current_user.parent_org_unit.try(:id)
    @procurement_request.status = Constants::PENDING
    respond_to do |format|
      if @procurement_request.save
        n = @procurement_request.notifications.build(name: @procurement_request.user.organization_unit.try(:to_s) << ' Procurement Request',
                                                  organization_unit_id: @procurement_request.organization_unit_id)
        n.save
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
      params.require(:procurement_request).permit(:organization_unit_id, :user_id, :status, :contact_phone, :contact_email,
                                                  :request_date, :comment, :decision_by, :attachment,
                                                  procurement_request_equipments_attributes: [:id, :equipment_name_id, :specification_id, :quantity, :approved_quantity, :_destroy],
                                                  procurement_request_spare_parts_attributes: [:id, :spare_part_id, :description, :requested_quantity, :approved_quantity, :_destroy],
                                                  forwards_attributes: [:id, :forwardable_id, :institution_id, :organization_unit_id, :_destroy])
    end
end
