class EpsaStatusesController < ApplicationController
  before_action :set_epsa_status, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Status at EPSA", :epsa_statuses_path

  # GET /epsa_statuses
  # GET /epsa_statuses.json
  def index
    @epsa_statuses = EpsaStatus.all
  end

  # GET /epsa_statuses/1
  # GET /epsa_statuses/1.json
  def show
  end

  # GET /epsa_statuses/new
  def new
    @epsa_status = EpsaStatus.new
  end

  # GET /epsa_statuses/1/edit
  def edit
  end

  # POST /epsa_statuses
  # POST /epsa_statuses.json
  def create
    @epsa_status = EpsaStatus.new(epsa_status_params)

    respond_to do |format|
      if @epsa_status.save
        format.html { redirect_to epsa_statuses_path, notice: 'EPSA status was successfully created.' }
        format.json { render :show, status: :created, location: @epsa_status }
      else
        format.html { render :new }
        format.json { render json: @epsa_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /epsa_statuses/1
  # PATCH/PUT /epsa_statuses/1.json
  def update
    respond_to do |format|
      if @epsa_status.update(epsa_status_params)
        format.html { redirect_to epsa_statuses_path, notice: 'EPSA status was successfully updated.' }
        format.json { render :show, status: :ok, location: @epsa_status }
      else
        format.html { render :edit }
        format.json { render json: @epsa_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /epsa_statuses/1
  # DELETE /epsa_statuses/1.json
  def destroy
    @epsa_status.destroy
    respond_to do |format|
      format.html { redirect_to epsa_statuses_url, notice: 'EPSA status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_epsa_status
      @epsa_status = EpsaStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def epsa_status_params
      params.require(:epsa_status).permit(:name, :epsa_team_id)
    end
end
