class DistributionsController < ApplicationController
  before_action :set_distribution, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Distributions", :distributions_path

  # GET /distributions
  # GET /distributions.json
  def index
    @distributions = current_user.distributions
  end

  def hub_allocations
    hub = EpsaHub.first
    @requests = hub.new_requests
  end

  # GET /distributions/1
  # GET /distributions/1.json
  def show
    add_breadcrumb "Details", :distribution_path
  end

  # GET /distributions/new
  def new
    add_breadcrumb "New", :new_distribution_path
    @distribution = Distribution.new
    @distribution.sub_distributions.build
  end

  # GET /distributions/1/edit
  def edit
    add_breadcrumb "Edit", :edit_distribution_path
  end

  # POST /distributions
  # POST /distributions.json
  def create
    epsa = Institution.find_by(name: 'EPSA')
    @distribution = Distribution.new(distribution_params)
    @distribution.institution_id = epsa.try(:id)
    respond_to do |format|
      if @distribution.save
        format.html { redirect_to @distribution, notice: 'Distribution was successfully created.' }
        format.json { render :show, status: :created, location: @distribution }
      else
        format.html { render :new }
        format.json { render json: @distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /distributions/1
  # PATCH/PUT /distributions/1.json
  def update
    respond_to do |format|
      if @distribution.update(distribution_params)
        format.html { redirect_to @distribution, notice: 'Distribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @distribution }
      else
        format.html { render :edit }
        format.json { render json: @distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /distributions/1
  # DELETE /distributions/1.json
  def destroy
    @distribution.destroy
    respond_to do |format|
      format.html { redirect_to distributions_url, notice: 'Distribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_distribution
      @distribution = Distribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def distribution_params
      params.require(:distribution).permit(:institution_id, :equipment_name_id, :request_date, sub_distributions_attributes: [:id, :organization_unit_id, :epsa_hub_id, :quantity, :_destroy])
    end
end
