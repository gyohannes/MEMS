class EquipmentCategoriesController < ApplicationController
  before_action :set_equipment_category, only: [:show, :edit, :update, :destroy]

  # GET /equipment_categories
  # GET /equipment_categories.json
  def index
    @equipment_categories = EquipmentCategory.all
  end

  # GET /equipment_categories/1
  # GET /equipment_categories/1.json
  def show
  end

  # GET /equipment_categories/new
  def new
    @equipment_category = EquipmentCategory.new
  end

  # GET /equipment_categories/1/edit
  def edit
  end

  # POST /equipment_categories
  # POST /equipment_categories.json
  def create
    @equipment_category = EquipmentCategory.new(equipment_category_params)

    respond_to do |format|
      if @equipment_category.save
        format.html { redirect_to equipment_categories_path, notice: 'Equipment category was successfully created.' }
        format.json { render :show, status: :created, location: @equipment_category }
      else
        format.html { render :new }
        format.json { render json: @equipment_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment_categories/1
  # PATCH/PUT /equipment_categories/1.json
  def update
    respond_to do |format|
      if @equipment_category.update(equipment_category_params)
        format.html { redirect_to equipment_categories_path, notice: 'Equipment category was successfully updated.' }
        format.json { render :show, status: :ok, location: @equipment_category }
      else
        format.html { render :edit }
        format.json { render json: @equipment_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment_categories/1
  # DELETE /equipment_categories/1.json
  def destroy
    @equipment_category.destroy
    respond_to do |format|
      format.html { redirect_to equipment_categories_url, notice: 'Equipment category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment_category
      @equipment_category = EquipmentCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_category_params
      params.require(:equipment_category).permit(:name)
    end
end
