class DisposalsController < ApplicationController
  load_and_authorize_resource
  before_action :set_disposal, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update, :index]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Disposals", :disposals_path

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
    add_breadcrumb "Details", :disposal_path
  end

  # GET /disposals/new
  def new
    add_breadcrumb "New", :new_disposal_path

    @disposal = Disposal.new
    @disposal.equipment_id = params[:equipment]
    session[:return_to] = request.referer
  end

  # GET /disposals/1/edit
  def edit
    add_breadcrumb "Edit", :edit_disposal_path
    session[:return_to] = request.referer
  end

  # POST /disposals
  # POST /disposals.json
  def create
    @disposal = Disposal.new(disposal_params)
    equipment = @disposal.equipment
    respond_to do |format|
      if @disposal.save
        equipment.update_attribute('status_id', Status.disposed_status)
        format.html { redirect_to session.delete(:return_to), notice: 'Disposal was successfully created.' }
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
        format.html { redirect_to session.delete(:return_to), notice: 'Disposal was successfully updated.' }
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
      params.require(:disposal).permit(:equipment_id, :reason_for_disposal, :disposal_method, :disposing_committee, :disposed_date, :attachment)
    end
end
