class OrganizationUnitsController < BaseController
  before_action :set_organization_unit, only: [:show, :edit, :update, :destroy]

  # GET /organization_units
  # GET /organization_units.json
  def index
    @organization_units = OrganizationUnit.all
  end

  def load_tree
    render json: OrganizationUnit.organization_tree(current_user)
  end

  def load_all_tree
    render json: OrganizationUnit.organization_tree
  end

  def load_facility_tree
    render json: OrganizationUnit.facilities_tree
  end

  def load_sub_units
    @parent  = OrganizationUnit.find(params[:node]) if params[:type] == 'org unit'
    @organization_units = @parent.sub_units
    render partial: 'organization_units'
  end

  # GET /organization_units/1
  # GET /organization_units/1.json
  def show
  end

  # GET /organization_units/new
  def new
    @organization_unit = OrganizationUnit.new
    if params[:parent]
      @parent = OrganizationUnit.find(params[:parent])
      @organization_unit.parent_organization_unit = @parent
    end
  end

  # GET /organization_units/1/edit
  def edit
  end

  # POST /organization_units
  # POST /organization_units.json
  def create
    @organization_unit = OrganizationUnit.new(organization_unit_params)

    respond_to do |format|
      if @organization_unit.save
        format.html { redirect_to organization_units_path, notice: 'Organization Unit was successfully created.' }
        format.json { render :show, status: :created, location: @organization_unit }
      else
        format.html { render :new }
        format.json { render json: @organization_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organization_units/1
  # PATCH/PUT /organization_units/1.json
  def update
    respond_to do |format|
      if @organization_unit.update(organization_unit_params)
        format.html { redirect_to organization_units_path, notice: 'Organization Unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization_unit }
      else
        format.html { render :edit }
        format.json { render json: @organization_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organization_units/1
  # DELETE /organization_units/1.json
  def destroy
    @organization_unit.destroy
    respond_to do |format|
      format.html { redirect_to organization_units_url, notice: 'Organization Unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization_unit
      @organization_unit = OrganizationUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_unit_params
      params.require(:organization_unit).permit(:name, :code, :organization_unit_type_id, :parent_organization_unit_id,
                                                :category, :url, :latitude, :longtitude, :note, :population, :facility, :administration_unit)
    end
end
