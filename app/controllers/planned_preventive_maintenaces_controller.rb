class PlannedPreventiveMaintenacesController < ApplicationController
  before_action :set_planned_preventive_maintenace, only: [:show, :edit, :update, :destroy]

  # GET /planned_preventive_maintenaces
  # GET /planned_preventive_maintenaces.json
  def index
    @planned_preventive_maintenaces = PlannedPreventiveMaintenace.all
  end

  # GET /planned_preventive_maintenaces/1
  # GET /planned_preventive_maintenaces/1.json
  def show
  end

  # GET /planned_preventive_maintenaces/new
  def new
    @planned_preventive_maintenace = PlannedPreventiveMaintenace.new
  end

  # GET /planned_preventive_maintenaces/1/edit
  def edit
  end

  # POST /planned_preventive_maintenaces
  # POST /planned_preventive_maintenaces.json
  def create
    @planned_preventive_maintenace = PlannedPreventiveMaintenace.new(planned_preventive_maintenace_params)

    respond_to do |format|
      if @planned_preventive_maintenace.save
        format.html { redirect_to @planned_preventive_maintenace, notice: 'Planned preventive maintenace was successfully created.' }
        format.json { render :show, status: :created, location: @planned_preventive_maintenace }
      else
        format.html { render :new }
        format.json { render json: @planned_preventive_maintenace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planned_preventive_maintenaces/1
  # PATCH/PUT /planned_preventive_maintenaces/1.json
  def update
    respond_to do |format|
      if @planned_preventive_maintenace.update(planned_preventive_maintenace_params)
        format.html { redirect_to @planned_preventive_maintenace, notice: 'Planned preventive maintenace was successfully updated.' }
        format.json { render :show, status: :ok, location: @planned_preventive_maintenace }
      else
        format.html { render :edit }
        format.json { render json: @planned_preventive_maintenace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planned_preventive_maintenaces/1
  # DELETE /planned_preventive_maintenaces/1.json
  def destroy
    @planned_preventive_maintenace.destroy
    respond_to do |format|
      format.html { redirect_to planned_preventive_maintenaces_url, notice: 'Planned preventive maintenace was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planned_preventive_maintenace
      @planned_preventive_maintenace = PlannedPreventiveMaintenace.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def planned_preventive_maintenace_params
      params.require(:planned_preventive_maintenace).permit(:user_id, :equipment_id, :action_taken, :maintained_date, :maintenace_cost, :enginneer_name_and_address, :next_ppm, :note)
    end
end
