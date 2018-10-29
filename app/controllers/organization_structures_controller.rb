class OrganizationStructuresController < BaseController
  before_action :set_organization_structure, only: [:show, :edit, :update, :destroy]

  # GET /organization_structures
  # GET /organization_structures.json
  def index
    @organization_structures = OrganizationStructure.all
  end

  def load_tree
    render json: OrganizationStructure.organization_tree(current_user)
  end

  def load_facility_tree
    render json: OrganizationStructure.facilities_tree
  end

  def load_sub_units
    @parent  = OrganizationStructure.find(params[:node]) if params[:type] == 'org unit'
    @organization_structures = @parent.sub_units
    render partial: 'organization_structures'
  end

  # GET /organization_structures/1
  # GET /organization_structures/1.json
  def show
  end

  # GET /organization_structures/new
  def new
    @organization_structure = OrganizationStructure.new
    if params[:parent]
      @parent = OrganizationStructure.find(params[:parent])
      @organization_structure.parent_organization_structure = @parent
    end
  end

  # GET /organization_structures/1/edit
  def edit
  end

  # POST /organization_structures
  # POST /organization_structures.json
  def create
    @organization_structure = OrganizationStructure.new(organization_structure_params)

    respond_to do |format|
      if @organization_structure.save
        format.html { redirect_to organization_structures_path, notice: 'Organization structure was successfully created.' }
        format.json { render :show, status: :created, location: @organization_structure }
      else
        format.html { render :new }
        format.json { render json: @organization_structure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organization_structures/1
  # PATCH/PUT /organization_structures/1.json
  def update
    respond_to do |format|
      if @organization_structure.update(organization_structure_params)
        format.html { redirect_to organization_structures_path, notice: 'Organization structure was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization_structure }
      else
        format.html { render :edit }
        format.json { render json: @organization_structure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organization_structures/1
  # DELETE /organization_structures/1.json
  def destroy
    @organization_structure.destroy
    respond_to do |format|
      format.html { redirect_to organization_structures_url, notice: 'Organization structure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization_structure
      @organization_structure = OrganizationStructure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_structure_params
      params.require(:organization_structure).permit(:name, :code, :organization_structure_type_id, :parent_organization_structure_id)
    end
end
