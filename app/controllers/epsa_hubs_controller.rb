class EpsaHubsController < ApplicationController
  before_action :set_epsa_hub, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "EPSA Hubs", :epsa_hubs_path

  # GET /epsa_hubs
  # GET /epsa_hubs.json
  def index
    @epsa_hubs = EpsaHub.all
  end

  # GET /epsa_hubs/1
  # GET /epsa_hubs/1.json
  def show
  end

  # GET /epsa_hubs/new
  def new
    @epsa_hub = EpsaHub.new
  end

  # GET /epsa_hubs/1/edit
  def edit
  end

  # POST /epsa_hubs
  # POST /epsa_hubs.json
  def create
    @epsa_hub = EpsaHub.new(epsa_hub_params)

    respond_to do |format|
      if @epsa_hub.save
        format.html { redirect_to epsa_hubs_path, notice: 'Epsa hub was successfully created.' }
        format.json { render :show, status: :created, location: @epsa_hub }
      else
        format.html { render :new }
        format.json { render json: @epsa_hub.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /epsa_hubs/1
  # PATCH/PUT /epsa_hubs/1.json
  def update
    respond_to do |format|
      if @epsa_hub.update(epsa_hub_params)
        format.html { redirect_to epsa_hubs_path, notice: 'Epsa hub was successfully updated.' }
        format.json { render :show, status: :ok, location: @epsa_hub }
      else
        format.html { render :edit }
        format.json { render json: @epsa_hub.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /epsa_hubs/1
  # DELETE /epsa_hubs/1.json
  def destroy
    @epsa_hub.destroy
    respond_to do |format|
      format.html { redirect_to epsa_hubs_url, notice: 'Epsa hub was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_epsa_hub
      @epsa_hub = EpsaHub.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def epsa_hub_params
      params.require(:epsa_hub).permit(:institution_id, :name)
    end
end
