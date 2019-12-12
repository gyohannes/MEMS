class InstitutionsController < BaseController
  before_action :set_institution, only: [:show, :edit, :update, :destroy]

  # GET /institutions
  # GET /institutions.json
  def index
    @institutions = !current_user.organization_unit.blank? ? current_user.organization_unit.sub_institutions : current_user.facility.institutions
  end

  def load_institutions
    @organization_unit  = OrganizationUnit.find(params[:node])
    @institutions = @organization_unit.sub_institutions
    render partial: 'institutions'
  end

  # GET /institutions/1
  # GET /institutions/1.json
  def show
  end

  # GET /institutions/new
  def new
    @organization_unit = OrganizationUnit.find_by(id: params[:organization_unit])
    @institution = Institution.new
    @institution.organization_unit = @organization_unit
  end

  # GET /institutions/1/edit
  def edit
    @organization_unit = @institution.organization_unit
  end

  # POST /institutions
  # POST /institutions.json
  def create
    @institution = Institution.new(institution_params)
    @organization_unit = @institution.organization_unit
    @facility = @institution.facility
    respond_to do |format|
      if @institution.save
        format.html { redirect_to institutions_path, notice: 'Institution was successfully created.' }
        format.json { render :show, status: :created, location: @institution }
      else
        format.html { render :new }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /institutions/1
  # PATCH/PUT /institutions/1.json
  def update
    @organization_unit = @institution.organization_unit
    @facility = @institution.facility
    respond_to do |format|
      if @institution.update(institution_params)
        format.html { redirect_to institutions_path, notice: 'Institution was successfully updated.' }
        format.json { render :show, status: :ok, location: @institution }
      else
        format.html { render :edit }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /institutions/1
  # DELETE /institutions/1.json
  def destroy
    @institution.destroy
    respond_to do |format|
      format.html { redirect_to institutions_url, notice: 'Institution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_institution
      @institution = Institution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def institution_params
      params.require(:institution).permit(:organization_unit_id, :facility_id, :name, :category, :institution_type,
                                          :contact_person, :contact_phone, :contact_email, :address)
    end
end
