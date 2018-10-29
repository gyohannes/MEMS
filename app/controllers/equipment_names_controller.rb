class EquipmentNamesController < ApplicationController
  before_action :set_equipment_name, only: [:show, :edit, :update, :destroy]

  # GET /equipment_names
  # GET /equipment_names.json
  def index
    @equipment_names = EquipmentName.all
  end

  # GET /equipment_names/1
  # GET /equipment_names/1.json
  def show
  end

  # GET /equipment_names/new
  def new
    @equipment_name = EquipmentName.new
  end

  # GET /equipment_names/1/edit
  def edit
  end

  # POST /equipment_names
  # POST /equipment_names.json
  def create
    @equipment_name = EquipmentName.new(equipment_name_params)

    respond_to do |format|
      if @equipment_name.save
        format.html { redirect_to equipment_names_path, notice: 'Equipment name was successfully created.' }
        format.json { render :show, status: :created, location: @equipment_name }
      else
        format.html { render :new }
        format.json { render json: @equipment_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment_names/1
  # PATCH/PUT /equipment_names/1.json
  def update
    respond_to do |format|
      if @equipment_name.update(equipment_name_params)
        format.html { redirect_to equipment_names_path, notice: 'Equipment name was successfully updated.' }
        format.json { render :show, status: :ok, location: @equipment_name }
      else
        format.html { render :edit }
        format.json { render json: @equipment_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment_names/1
  # DELETE /equipment_names/1.json
  def destroy
    @equipment_name.destroy
    respond_to do |format|
      format.html { redirect_to equipment_names_url, notice: 'Equipment name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment_name
      @equipment_name = EquipmentName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_name_params
      params.require(:equipment_name).permit(:equipment_category_id, :name)
    end
end
