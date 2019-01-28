class AcceptanceTestsController < ApplicationController
  before_action :set_acceptance_test, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update, :index]

  def load
    @equipments = current_user.load_equipment
  end
  # GET /installations
  # GET /installations.json
  def index
    @acceptance_tests = AcceptanceTest.joins(:equipment).where('equipment_id in (?)', @equipments.pluck(:id))
  end

  # GET /acceptance_tests/1
  # GET /acceptance_tests/1.json
  def show
  end

  # GET /acceptance_tests/new
  def new
    @acceptance_test = AcceptanceTest.new
    @acceptance_test.equipment_id = params[:equipment]
  end

  # GET /acceptance_tests/1/edit
  def edit
  end

  # POST /acceptance_tests
  # POST /acceptance_tests.json
  def create
    @acceptance_test = AcceptanceTest.new(acceptance_test_params)
    equipment = @acceptance_test.equipment
    respond_to do |format|
      if @acceptance_test.save
        equipment.update(status: @acceptance_test.status)
        format.html { redirect_to @acceptance_test, notice: 'Acceptance test was successfully created.' }
        format.json { render :show, status: :created, location: @acceptance_test }
      else
        format.html { render :new }
        format.json { render json: @acceptance_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acceptance_tests/1
  # PATCH/PUT /acceptance_tests/1.json
  def update
    equipment = @acceptance_test.equipment
    respond_to do |format|
      if @acceptance_test.update(acceptance_test_params)
        equipment.update(status: @acceptance_test.status)
        format.html { redirect_to @acceptance_test, notice: 'Acceptance test was successfully updated.' }
        format.json { render :show, status: :ok, location: @acceptance_test }
      else
        format.html { render :edit }
        format.json { render json: @acceptance_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acceptance_tests/1
  # DELETE /acceptance_tests/1.json
  def destroy
    @acceptance_test.destroy
    respond_to do |format|
      format.html { redirect_to acceptance_tests_url, notice: 'Acceptance test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acceptance_test
      @acceptance_test = AcceptanceTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acceptance_test_params
      params.require(:acceptance_test).permit(:equipment_id, :meet_standard, :with_order_specification, :installation_done, :test_run, :accepted, :maintenance_personnel_trained, :end_users_trained, :with_full_accessery, :with_manual, :status, :approved_by, :acceptance_testing_date, :contact_address, :note)
    end
end
