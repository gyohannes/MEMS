class ModelEquipmentListController < ApplicationController
  load_and_authorize_resource
  before_action :set_model_equipment_list, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Model Equipment List", :model_equipment_list_path
  # GET /model_equipment_list
  # GET /model_equipment_list.json
  def index
    @model_equipment_list = ModelEquipmentList.all
  end

  # GET /model_equipment_list/1
  # GET /model_equipment_list/1.json
  def show
  end

  # GET /model_equipment_list/new
  def new
    add_breadcrumb "Create List", :new_model_equipment_list_path
    @model_equipment_list = ModelEquipmentList.new
    @model_equipment_list.model_equipments.build
  end

  # GET /model_equipment_list/1/edit
  def edit
    add_breadcrumb "Edit List", :edit_model_equipment_list_path
  end

  # POST /model_equipment_list
  # POST /model_equipment_list.json
  def create
    @model_equipment_list = ModelEquipmentList.new(model_equipment_list_params)
    @model_equipment_list.organization_unit_id = current_user.organization_unit_id
    respond_to do |format|
      if @model_equipment_list.save
        format.html { redirect_to @model_equipment_list, notice: 'Model equipment list was successfully created.' }
        format.json { render :show, status: :created, location: @model_equipment_list }
      else
        format.html { render :new }
        format.json { render json: @model_equipment_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /model_equipment_list/1
  # PATCH/PUT /model_equipment_list/1.json
  def update
    respond_to do |format|
      if @model_equipment_list.update(model_equipment_list_params)
        format.html { redirect_to @model_equipment_list, notice: 'Model equipment list was successfully updated.' }
        format.json { render :show, status: :ok, location: @model_equipment_list }
      else
        format.html { render :edit }
        format.json { render json: @model_equipment_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /model_equipment_list/1
  # DELETE /model_equipment_list/1.json
  def destroy
    @model_equipment_list.destroy
    respond_to do |format|
      format.html { redirect_to model_equipment_list_index_url, notice: 'Model equipment list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model_equipment_list
      @model_equipment_list = ModelEquipmentList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_equipment_list_params
      params.require(:model_equipment_list).permit(:organization_unit_id, model_equipments_attributes: [:id, :equipment_name_id, :equipment_type_id, :quantity, :_destroy])
    end
end
