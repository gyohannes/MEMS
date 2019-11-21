class FacilityTypesController < BaseController
  before_action :set_facility_type, only: [:show, :edit, :update, :destroy]

  # GET /facility_types
  # GET /facility_types.json
  def index
    @facility_types = FacilityType.all
  end

  # GET /facility_types/1
  # GET /facility_types/1.json
  def show
  end

  # GET /facility_types/new
  def new
    @facility_type = FacilityType.new
  end

  # GET /facility_types/1/edit
  def edit
  end

  # POST /facility_types
  # POST /facility_types.json
  def create
    @facility_type = FacilityType.new(facility_type_params)

    respond_to do |format|
      if @facility_type.save
        format.html { redirect_to facility_types_path, notice: 'Facility type was successfully created.' }
        format.json { render :show, status: :created, location: @facility_type }
      else
        format.html { render :new }
        format.json { render json: @facility_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facility_types/1
  # PATCH/PUT /facility_types/1.json
  def update
    respond_to do |format|
      if @facility_type.update(facility_type_params)
        format.html { redirect_to facility_types_path, notice: 'Facility type was successfully updated.' }
        format.json { render :show, status: :ok, location: @facility_type }
      else
        format.html { render :edit }
        format.json { render json: @facility_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_types/1
  # DELETE /facility_types/1.json
  def destroy
    @facility_type.destroy
    respond_to do |format|
      format.html { redirect_to facility_types_url, notice: 'Facility type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility_type
      @facility_type = FacilityType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_type_params
      params.require(:facility_type).permit(:name, :description)
    end
end
