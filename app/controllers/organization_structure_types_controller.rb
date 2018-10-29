class OrganizationStructureTypesController < BaseController
  before_action :set_organization_structure_type, only: [:show, :edit, :update, :destroy]

  # GET /organization_structure_types
  # GET /organization_structure_types.json
  def index
    @organization_structure_types = OrganizationStructureType.all
  end

  # GET /organization_structure_types/1
  # GET /organization_structure_types/1.json
  def show
  end

  # GET /organization_structure_types/new
  def new
    @organization_structure_type = OrganizationStructureType.new
  end

  # GET /organization_structure_types/1/edit
  def edit
  end

  # POST /organization_structure_types
  # POST /organization_structure_types.json
  def create
    @organization_structure_type = OrganizationStructureType.new(organization_structure_type_params)

    respond_to do |format|
      if @organization_structure_type.save
        format.html { redirect_to organization_structure_types_path, notice: 'Organization structure type was successfully created.' }
        format.json { render :show, status: :created, location: @organization_structure_type }
      else
        format.html { render :new }
        format.json { render json: @organization_structure_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organization_structure_types/1
  # PATCH/PUT /organization_structure_types/1.json
  def update
    respond_to do |format|
      if @organization_structure_type.update(organization_structure_type_params)
        format.html { redirect_to organization_structure_types_path, notice: 'Organization structure type was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization_structure_type }
      else
        format.html { render :edit }
        format.json { render json: @organization_structure_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organization_structure_types/1
  # DELETE /organization_structure_types/1.json
  def destroy
    @organization_structure_type.destroy
    respond_to do |format|
      format.html { redirect_to organization_structure_types_url, notice: 'Organization structure type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization_structure_type
      @organization_structure_type = OrganizationStructureType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_structure_type_params
      params.require(:organization_structure_type).permit(:name, :description)
    end
end
