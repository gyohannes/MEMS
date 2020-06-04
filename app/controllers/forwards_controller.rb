class ForwardsController < ApplicationController
  load_and_authorize_resource
  before_action :set_forward, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Forwarded Requests", :forwards_path

  # GET /forwards
  # GET /forwards.json
  def index
    @forwards = Forward.all
  end

  # GET /forwards/1
  # GET /forwards/1.json
  def show
  end

  # GET /forwards/new
  def new
    @forward = Forward.new
  end

  # GET /forwards/1/edit
  def edit
  end

  # POST /forwards
  # POST /forwards.json
  def create
    @forward = Forward.new(forward_params)

    respond_to do |format|
      if @forward.save
        format.html { redirect_to @forward, notice: 'Forward was successfully created.' }
        format.json { render :show, status: :created, location: @forward }
      else
        format.html { render :new }
        format.json { render json: @forward.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forwards/1
  # PATCH/PUT /forwards/1.json
  def update
    respond_to do |format|
      if @forward.update(forward_params)
        format.html { redirect_to @forward, notice: 'Forward was successfully updated.' }
        format.json { render :show, status: :ok, location: @forward }
      else
        format.html { render :edit }
        format.json { render json: @forward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forwards/1
  # DELETE /forwards/1.json
  def destroy
    @forward.destroy
    respond_to do |format|
      format.html { redirect_to forwards_url, notice: 'Forward was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forward
      @forward = Forward.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forward_params
      params.require(:forward).permit(:organization_unit_id, :institution_id, :forwardable_id)
    end
end
