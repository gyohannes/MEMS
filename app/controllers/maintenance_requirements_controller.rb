class MaintenanceRequirementsController < ApplicationController
  before_action :set_maintenance_requirement, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Maintenance Requirements", :maintenance_requirements_path

  # GET /maintenance_requirements
  # GET /maintenance_requirements.json
  def index
    @maintenance_requirements = MaintenanceRequirement.all
  end

  # GET /maintenance_requirements/1
  # GET /maintenance_requirements/1.json
  def show
  end

  # GET /maintenance_requirements/new
  def new
    @maintenance_requirement = MaintenanceRequirement.new
  end

  # GET /maintenance_requirements/1/edit
  def edit
  end

  # POST /maintenance_requirements
  # POST /maintenance_requirements.json
  def create
    @maintenance_requirement = MaintenanceRequirement.new(maintenance_requirement_params)

    respond_to do |format|
      if @maintenance_requirement.save
        format.html { redirect_to maintenance_requirements_path, notice: 'Maintenance requirement was successfully created.' }
        format.json { render :show, status: :created, location: @maintenance_requirement }
      else
        format.html { render :new }
        format.json { render json: @maintenance_requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenance_requirements/1
  # PATCH/PUT /maintenance_requirements/1.json
  def update
    respond_to do |format|
      if @maintenance_requirement.update(maintenance_requirement_params)
        format.html { redirect_to maintenance_requirements_path, notice: 'Maintenance requirement was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintenance_requirement }
      else
        format.html { render :edit }
        format.json { render json: @maintenance_requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_requirements/1
  # DELETE /maintenance_requirements/1.json
  def destroy
    @maintenance_requirement.destroy
    respond_to do |format|
      format.html { redirect_to maintenance_requirements_url, notice: 'Maintenance requirement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_requirement
      @maintenance_requirement = MaintenanceRequirement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintenance_requirement_params
      params.require(:maintenance_requirement).permit(:name, :days)
    end
end
