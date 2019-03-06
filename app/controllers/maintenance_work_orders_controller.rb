class MaintenanceWorkOrdersController < ApplicationController
  before_action :set_maintenance_work_order, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update]

  def load
    @engineers = current_user.load_users(Constants::BIOMEDICAL_ENGINEER)
    @equipment = current_user.load_equipment
  end
  # GET /maintenance_work_orders
  # GET /maintenance_work_orders.json
  def index
    @maintenance_work_orders = []
    if current_user.is_role(Constants::BIOMEDICAL_HEAD)
      @maintenance_work_orders = MaintenanceWorkOrder.joins(:equipment).where('equipment.id in (?)', current_user.load_equipment.pluck(:id))
    elsif current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
      @maintenance_work_orders = current_user.maintenance_work_orders
    end

  end

  # GET /maintenance_work_orders/1
  # GET /maintenance_work_orders/1.json
  def show
  end

  # GET /maintenance_work_orders/new
  def new
    @maintenance_work_order = MaintenanceWorkOrder.new
  end

  # GET /maintenance_work_orders/1/edit
  def edit
  end

  # POST /maintenance_work_orders
  # POST /maintenance_work_orders.json
  def create
    @maintenance_work_order = MaintenanceWorkOrder.new(maintenance_work_order_params)
    @maintenance_work_order.status = Constants::PENDING
    respond_to do |format|
      if @maintenance_work_order.save
        format.html { redirect_to @maintenance_work_order, notice: 'Maintenance work order was successfully created.' }
        format.json { render :show, status: :created, location: @maintenance_work_order }
      else
        format.html { render :new }
        format.json { render json: @maintenance_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenance_work_orders/1
  # PATCH/PUT /maintenance_work_orders/1.json
  def update
    respond_to do |format|
      if @maintenance_work_order.update(maintenance_work_order_params)
        format.html { redirect_to @maintenance_work_order, notice: 'Maintenance work order was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintenance_work_order }
      else
        format.html { render :edit }
        format.json { render json: @maintenance_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_work_orders/1
  # DELETE /maintenance_work_orders/1.json
  def destroy
    @maintenance_work_order.destroy
    respond_to do |format|
      format.html { redirect_to maintenance_work_orders_url, notice: 'Maintenance work order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_work_order
      @maintenance_work_order = MaintenanceWorkOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintenance_work_order_params
      params.require(:maintenance_work_order).permit(:equipment_id, :user_id, :location, :date, :description_of_problem, :status, :note)
    end
end