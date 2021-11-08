class EquipmentIssuesController < ApplicationController
  before_action :set_equipment_issue, only: [:show, :edit, :update, :destroy, :confirm_delivery]

  # GET /equipment_issues
  # GET /equipment_issues.json
  def index
    @equipment_issues = current_user.epsa_hub.equipment_issues
  end

  def new_deliveries
    @new_deliveries = current_user.organization_unit.new_equipment_deliveries
  end

  def confirm_delivery
    @equipment_issue.update_attribute('status', true)
    redirect_to new_deliveries_path, notice: 'Delivery successfully confirmed'
  end

  # GET /equipment_issues/1
  # GET /equipment_issues/1.json
  def show
  end

  # GET /equipment_issues/new
  def new
    sub_distribution = SubDistribution.find_by(id: params[:subd])
    @equipment_issue = EquipmentIssue.new
    @equipment_issue.sub_distribution_id = sub_distribution.id
    @equipment_issue.quantity = sub_distribution.quantity
  end

  # GET /equipment_issues/1/edit
  def edit
  end

  # POST /equipment_issues
  # POST /equipment_issues.json
  def create
    @equipment_issue = EquipmentIssue.new(equipment_issue_params)

    respond_to do |format|
      if @equipment_issue.save
        format.html { redirect_to equipment_issues_path, notice: 'Equipment issue was successfully created.' }
        format.json { render :show, status: :created, location: @equipment_issue }
      else
        format.html { render :new }
        format.json { render json: @equipment_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment_issues/1
  # PATCH/PUT /equipment_issues/1.json
  def update
    respond_to do |format|
      if @equipment_issue.update(equipment_issue_params)
        format.html { redirect_to equipment_issues_path, notice: 'Equipment issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @equipment_issue }
      else
        format.html { render :edit }
        format.json { render json: @equipment_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment_issues/1
  # DELETE /equipment_issues/1.json
  def destroy
    @equipment_issue.destroy
    respond_to do |format|
      format.html { redirect_to equipment_issues_url, notice: 'Equipment issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment_issue
      @equipment_issue = EquipmentIssue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_issue_params
      params.require(:equipment_issue).permit(:sub_distribution_id, :quantity, :issued_by, :issue_date, :remark, :GRV_number, :STV_number, :model, :received_by, :receiver_contact_address)
    end
end
