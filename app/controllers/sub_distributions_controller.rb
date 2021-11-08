class SubDistributionsController < ApplicationController
  before_action :set_sub_distribution, only: [:show, :edit, :update, :destroy]

  # GET /sub_distributions
  # GET /sub_distributions.json
  def index
    @sub_distributions = EpsaHub.first.new_requests
  end

  # GET /sub_distributions/1
  # GET /sub_distributions/1.json
  def show
  end

  # GET /sub_distributions/new
  def new
    @sub_distribution = SubDistribution.new
  end

  # GET /sub_distributions/1/edit
  def edit
  end

  # POST /sub_distributions
  # POST /sub_distributions.json
  def create
    @sub_distribution = SubDistribution.new(sub_distribution_params)

    respond_to do |format|
      if @sub_distribution.save
        format.html { redirect_to @sub_distribution, notice: 'Sub distribution was successfully created.' }
        format.json { render :show, status: :created, location: @sub_distribution }
      else
        format.html { render :new }
        format.json { render json: @sub_distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_distributions/1
  # PATCH/PUT /sub_distributions/1.json
  def update
    respond_to do |format|
      if @sub_distribution.update(sub_distribution_params)
        format.html { redirect_to @sub_distribution, notice: 'Sub distribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_distribution }
      else
        format.html { render :edit }
        format.json { render json: @sub_distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_distributions/1
  # DELETE /sub_distributions/1.json
  def destroy
    @sub_distribution.destroy
    respond_to do |format|
      format.html { redirect_to sub_distributions_url, notice: 'Sub distribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_distribution
      @sub_distribution = SubDistribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_distribution_params
      params.require(:sub_distribution).permit(:distribution_id, :organization_unit_id, :quantity, :remark, :status, :epsa_hub_id)
    end
end
