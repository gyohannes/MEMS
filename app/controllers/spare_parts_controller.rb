class SparePartsController < ApplicationController
  load_and_authorize_resource
  before_action :set_spare_part, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Spare Parts", :spare_parts_path
  # GET /spare_parts
  # GET /spare_parts.json
  def index
    @spare_parts = current_user.organization_unit.spare_parts
  end

  def ideal_vs_available_by_type
    spare_parts = current_user.organization_unit.spare_parts
    spare_part_stats = []
    ['Min Re-order Level', 'Available'].each do |type|
      spare_part_stats << {name: type, data: spare_parts.map{|sp| [sp.to_s, sp.min_re_order_level_vs_available(type)]} }
    end
    render json: spare_part_stats
  end

  # GET /spare_parts/1
  # GET /spare_parts/1.json
  def show
  end

  # GET /spare_parts/new
  def new
    @spare_part = SparePart.new
  end

  # GET /spare_parts/1/edit
  def edit
  end

  # POST /spare_parts
  # POST /spare_parts.json
  def create
    @spare_part = SparePart.new(spare_part_params)
    @spare_part.organization_unit_id = current_user.organization_unit_id
    respond_to do |format|
      if @spare_part.save
        format.html { redirect_to @spare_part, notice: 'Spare part was successfully created.' }
        format.json { render :show, status: :created, location: @spare_part }
      else
        format.html { render :new }
        format.json { render json: @spare_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spare_parts/1
  # PATCH/PUT /spare_parts/1.json
  def update
    respond_to do |format|
      if @spare_part.update(spare_part_params)
        format.html { redirect_to @spare_part, notice: 'Spare part was successfully updated.' }
        format.json { render :show, status: :ok, location: @spare_part }
      else
        format.html { render :edit }
        format.json { render json: @spare_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spare_parts/1
  # DELETE /spare_parts/1.json
  def destroy
    @spare_part.destroy
    respond_to do |format|
      format.html { redirect_to spare_parts_url, notice: 'Spare part was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spare_part
      @spare_part = SparePart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spare_part_params
      params.require(:spare_part).permit(:organization_unit_id, :equipment_name_id, :name, :item_code_number, :description, :uom,
                                         :max_stock_level, :min_reorder_level, :lead_time, :order_quantity )
    end
end
