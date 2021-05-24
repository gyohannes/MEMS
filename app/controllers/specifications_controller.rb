class SpecificationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_specification, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Specifications", :specifications_path

  # GET /specifications
  # GET /specifications.json
  def index
    @specifications = Specification.all
  end

  def import
    add_breadcrumb "Import", :import_specifications_path
    if request.post?
      @specifications = Specification.import_specifications(params[:specifications_csv_file])
      flash[:notice] = @specifications.blank? ? 'No specification imported' : 'Specifications imported'
    end
    redirect_to specifications_path
  end

  # GET /specifications/1
  # GET /specifications/1.json
  def show
    add_breadcrumb "Details", :specification_path

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "Equipment Specification",
               :encoding => 'utf-8',
               :disposition => 'attachment',
               :margin => {
                   :top => 10,
                   :bottom => 10
               }
      end
    end
  end

  # GET /specifications/new
  def new
    @departments = current_user.organization_unit.departments
    add_breadcrumb "New", :new_specification_path

    @specification = Specification.new
  end

  # GET /specifications/1/edit
  def edit
    @departments = current_user.organization_unit.departments
    add_breadcrumb "Edit", :edit_specification_path
  end

  # POST /specifications
  # POST /specifications.json
  def create
    @departments = current_user.organization_unit.departments
    @specification = Specification.new(specification_params)
    respond_to do |format|
      if @specification.save
        format.html { redirect_to @specification, notice: 'Specification was successfully created.' }
        format.json { render :show, status: :created, location: @specification }
      else
        format.html { render :new }
        format.json { render json: @specification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /specifications/1
  # PATCH/PUT /specifications/1.json
  def update
    @departments = current_user.organization_unit.departments
    respond_to do |format|
      if @specification.update(specification_params)
        format.html { redirect_to @specification, notice: 'Specification was successfully updated.' }
        format.json { render :show, status: :ok, location: @specification }
      else
        format.html { render :edit }
        format.json { render json: @specification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specifications/1
  # DELETE /specifications/1.json
  def destroy
    @specification.destroy
    respond_to do |format|
      format.html { redirect_to specifications_url, notice: 'Specification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_specification
      @specification = Specification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def specification_params
      params.require(:specification).permit(:organization_unit_type_id, :equipment_name_id, :department_id, :item_detail)
    end
end
