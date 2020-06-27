class ReceivesController < ApplicationController
  load_and_authorize_resource
  before_action :set_receive, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Item Receives", :receives_path

  def load
    @stores = current_user.organization_unit ? current_user.organization_unit.stores : []
    @spare_parts = current_user.organization_unit.spare_parts
  end
  # GET /receives
  # GET /receives.json
  def index
    @receives = []
    if current_user.store
      @receives = current_user.store.receive
    elsif current_user.organization_unit
      @receives = current_user.organization_unit.sub_receive
    end
    return @receives
  end

  # GET /receives/1
  # GET /receives/1.json
  def show
    add_breadcrumb "Details", :receive_path

    respond_to do |format|
      format.html # show.html.erb
      format.pdf do
        render :pdf => "Equipment Receipt",
               :encoding => 'utf-8',
               :disposition => 'attachment',
               :margin => {
                   :top => 40,
                   :bottom => 25
               },
               :header => {
                   :spacing => 5,
                   :html => {
                       :template => 'receives/_header.html',
                       :margin => { :top => 0, :bottom => 0 }
                   }
               },
               :footer => {
                   :html => {
                       :template => 'receives/_footer.html',
                   }
               }
      end
    end
  end

  # GET /receives/new
  def new
    add_breadcrumb "New", :new_receive_path

    @receive = Receive.new
  end

  # GET /receives/1/edit
  def edit
    add_breadcrumb "Edit", :edit_receive_path
  end

  # POST /receives
  # POST /receives.json
  def create
    @receive = Receive.new(receive_params)

    respond_to do |format|
      if @receive.save
        format.html { redirect_to @receive, notice: 'Receive was successfully created.' }
        format.json { render :show, status: :created, location: @receive }
      else
        format.html { render :new }
        format.json { render json: @receive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receives/1
  # PATCH/PUT /receives/1.json
  def update
    respond_to do |format|
      if @receive.update(receive_params)
        format.html { redirect_to @receive, notice: 'Receive was successfully updated.' }
        format.json { render :show, status: :ok, location: @receive }
      else
        format.html { render :edit }
        format.json { render json: @receive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receives/1
  # DELETE /receives/1.json
  def destroy
    @receive.destroy
    respond_to do |format|
      format.html { redirect_to receives_url, notice: 'Receive was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receive
      @receive = Receive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def receive_params
      params.require(:receive).permit(:store_id, :reference_number, :deliverer_name, :recipient_name, :receive_date, :note,
                                      receive_spare_parts_attributes: [:id, :receive_id, :spare_part_id, :quantity,
                                                                       :unit_price, :expiry_date, :remarks, :_destroy],
                                      receive_equipment_attributes: [:id, :receive_id, :equipment_name_id, :quantity,
                                                                       :unit_cost, :model, :description, :_destroy])
    end
end
