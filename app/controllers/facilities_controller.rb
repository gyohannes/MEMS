class FacilitiesController < BaseController
  before_action :set_facility, only: [:show, :edit, :update, :destroy]

  # GET /facilities
  # GET /facilities.json
  def index
    org_unit = current_user.organization_structure
    @facilities = org_unit.try(:sub_facilities) || []
  end

  def load_facilities
    @organization_structure  = OrganizationStructure.find(params[:node])
    @facilities = @organization_structure.sub_facilities
    render partial: 'facilities'
  end
  # GET /facilities/1
  # GET /facilities/1.json
  def show
  end

  # GET /facilities/new
  def new
    @organization_structure = OrganizationStructure.find(params[:organization_structure])
    @facility = Facility.new
    @facility.organization_structure = @organization_structure
  end

  # GET /facilities/1/edit
  def edit
    @organization_structure = @facility.organization_structure
  end

  # POST /facilities
  # POST /facilities.json
  def create
    @facility = Facility.new(facility_params)
    @organization_structure = @facility.organization_structure
    respond_to do |format|
      if @facility.save
        format.html { redirect_to @facility, notice: 'Facility was successfully created.' }
        format.json { render :show, status: :created, location: @facility }
      else
        format.html { render :new }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facilities/1
  # PATCH/PUT /facilities/1.json
  def update
    @organization_structure = @facility.organization_structure
    respond_to do |format|
      if @facility.update(facility_params)
        format.html { redirect_to @facility, notice: 'Facility was successfully updated.' }
        format.json { render :show, status: :ok, location: @facility }
      else
        format.html { render :edit }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    @facility.destroy
    respond_to do |format|
      format.html { redirect_to facilities_url, notice: 'Facility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_params
      params.require(:facility).permit(:organization_structure_id, :name, :code, :facility_type_id, :category, :url, :latitude, :longitude, :population, :note)
    end
end
