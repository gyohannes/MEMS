class BudgetRequestsController < ApplicationController
  before_action :set_budget_request, only: [:show, :edit, :update, :destroy, :decision]

  # GET /budget_requests
  # GET /budget_requests.json
  def index
    if current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @budget_requests = current_user.budget_requests
    elsif current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @budget_requests = current_user.budget_requests + current_user.incoming_budget_requests
    else
      @budget_requests = []
    end
  end

  # GET /budget_requests/1
  # GET /budget_requests/1.json
  def show
  end

  # GET /budget_requests/new
  def new
    @budget_request = BudgetRequest.new
  end

  def load_request_to
    @request_to_type = params[:request_to]
    @institutions = Institution.where('category = ?', @request_to_type)
    render partial: 'request_to'
  end

  def decision
    @budget_request.update(budget_request_params)
    @budget_request.update(status: params[:status])
    redirect_to @budget_request, notice: "Budget request was successfully #{params[:status]}."
  end

  # GET /budget_requests/1/edit
  def edit
    @request_to_type = @budget_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
  end

  # POST /budget_requests
  # POST /budget_requests.json
  def create
    @budget_request = BudgetRequest.new(budget_request_params)
    @request_to_type = @budget_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @budget_request.save
        @budget_request.update(status: Constants::PENDING)
        format.html { redirect_to @budget_request, notice: 'Budget request was successfully created.' }
        format.json { render :show, status: :created, location: @budget_request }
      else
        format.html { render :new }
        format.json { render json: @budget_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budget_requests/1
  # PATCH/PUT /budget_requests/1.json
  def update
    @request_to_type = @budget_request.request_to
    @institutions = Institution.where('category = ?', @request_to_type)
    respond_to do |format|
      if @budget_request.update(budget_request_params)
        format.html { redirect_to @budget_request, notice: 'Budget request was successfully updated.' }
        format.json { render :show, status: :ok, location: @budget_request }
      else
        format.html { render :edit }
        format.json { render json: @budget_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budget_requests/1
  # DELETE /budget_requests/1.json
  def destroy
    @budget_request.destroy
    respond_to do |format|
      format.html { redirect_to budget_requests_url, notice: 'Budget request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget_request
      @budget_request = BudgetRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_request_params
      params.require(:budget_request).permit(:organization_structure_id, :facility_id, :budget_name, :budget_description, :amount, :request_to, :contact_address, :user_id, :request_date, :comment, :decision_by)
    end
end
