class BudgetRequestsController < ApplicationController
  before_action :set_budget_request, only: [:show, :edit, :update, :destroy]

  # GET /budget_requests
  # GET /budget_requests.json
  def index
    @budget_requests = BudgetRequest.all
  end

  # GET /budget_requests/1
  # GET /budget_requests/1.json
  def show
  end

  # GET /budget_requests/new
  def new
    @budget_request = BudgetRequest.new
  end

  # GET /budget_requests/1/edit
  def edit
  end

  # POST /budget_requests
  # POST /budget_requests.json
  def create
    @budget_request = BudgetRequest.new(budget_request_params)

    respond_to do |format|
      if @budget_request.save
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
      params.require(:budget_request).permit(:organization_structure_id, :facility_id, :budget_name, :budget_description, :amount, :requested_to, :request_to_org_structure, :request_to_facility, :contact_address, :requested_by, :request_date)
    end
end
