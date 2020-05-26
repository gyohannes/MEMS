class OrganizationUnitTypesController < BaseController
  before_action :set_organization_unit_type, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Organization Types", :organization_unit_types_path

  # GET /organization_unit_types
  # GET /organization_unit_types.json
  def index
    @organization_unit_types = OrganizationUnitType.all
  end

  # GET /organization_unit_types/1
  # GET /organization_unit_types/1.json
  def show
  end

  # GET /organization_unit_types/new
  def new
    @organization_unit_type = OrganizationUnitType.new
  end

  # GET /organization_unit_types/1/edit
  def edit
  end

  # POST /organization_unit_types
  # POST /organization_unit_types.json
  def create
    @organization_unit_type = OrganizationUnitType.new(organization_unit_type_params)

    respond_to do |format|
      if @organization_unit_type.save
        format.html { redirect_to organization_unit_types_path, notice: 'Organization Unit type was successfully created.' }
        format.json { render :show, status: :created, location: @organization_unit_type }
      else
        format.html { render :new }
        format.json { render json: @organization_unit_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organization_unit_types/1
  # PATCH/PUT /organization_unit_types/1.json
  def update
    respond_to do |format|
      if @organization_unit_type.update(organization_unit_type_params)
        format.html { redirect_to organization_unit_types_path, notice: 'Organization Unit type was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization_unit_type }
      else
        format.html { render :edit }
        format.json { render json: @organization_unit_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organization_unit_types/1
  # DELETE /organization_unit_types/1.json
  def destroy
    @organization_unit_type.destroy
    respond_to do |format|
      format.html { redirect_to organization_unit_types_url, notice: 'Organization Unit type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization_unit_type
      @organization_unit_type = OrganizationUnitType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_unit_type_params
      params.require(:organization_unit_type).permit(:name, :description)
    end
end
