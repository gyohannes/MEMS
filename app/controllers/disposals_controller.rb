class DisposalsController < ApplicationController
  before_action :set_disposal, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update, :index]

  def load
    @equipments = current_user.load_equipment
  end
  # GET /installations
  # GET /installations.json
  def index
    @disposals = Disposal.joins(:equipment).where('equipment_id in (?)', @equipments.pluck(:id))
  end

  # GET /disposals/1
  # GET /disposals/1.json
  def show
  end

  # GET /disposals/new
  def new
    @disposal = Disposal.new
    @disposal.equipment_id = params[:equipment]
  end

  # GET /disposals/1/edit
  def edit
  end

  # POST /disposals
  # POST /disposals.json
  def create
    @disposal = Disposal.new(disposal_params)
    equipment = @disposal.equipment
    respond_to do |format|
      if @disposal.save
        equipment.update(status: Equipment::DISPOSED)
        format.html { redirect_to @disposal, notice: 'Disposal was successfully created.' }
        format.json { render :show, status: :created, location: @disposal }
      else
        format.html { render :new }
        format.json { render json: @disposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disposals/1
  # PATCH/PUT /disposals/1.json
  def update
    respond_to do |format|
      if @disposal.update(disposal_params)
        format.html { redirect_to @disposal, notice: 'Disposal was successfully updated.' }
        format.json { render :show, status: :ok, location: @disposal }
      else
        format.html { render :edit }
        format.json { render json: @disposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disposals/1
  # DELETE /disposals/1.json
  def destroy
    @disposal.destroy
    respond_to do |format|
      format.html { redirect_to disposals_url, notice: 'Disposal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disposal
      @disposal = Disposal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disposal_params
      params.require(:disposal).permit(:equipment_id, :problem, :action_taken, :list_of_disposing_commitee, :contact_address, :disposed_date)
    end
end
