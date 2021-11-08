class EpsaTeamsController < ApplicationController
  before_action :set_epsa_team, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "EPSA Teams", :epsa_teams_path
  # GET /epsa_teams
  # GET /epsa_teams.json
  def index
    @epsa_teams = EpsaTeam.all
  end

  # GET /epsa_teams/1
  # GET /epsa_teams/1.json
  def show
  end

  # GET /epsa_teams/new
  def new
    @epsa_team = EpsaTeam.new
  end

  # GET /epsa_teams/1/edit
  def edit
  end

  # POST /epsa_teams
  # POST /epsa_teams.json
  def create
    @epsa_team = EpsaTeam.new(epsa_team_params)

    respond_to do |format|
      if @epsa_team.save
        format.html { redirect_to epsa_teams_path, notice: 'EPSA team was successfully created.' }
        format.json { render :show, status: :created, location: @epsa_team }
      else
        format.html { render :new }
        format.json { render json: @epsa_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /epsa_teams/1
  # PATCH/PUT /epsa_teams/1.json
  def update
    respond_to do |format|
      if @epsa_team.update(epsa_team_params)
        format.html { redirect_to epsa_teams_path, notice: 'EPSA team was successfully updated.' }
        format.json { render :show, status: :ok, location: @epsa_team }
      else
        format.html { render :edit }
        format.json { render json: @epsa_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /epsa_teams/1
  # DELETE /epsa_teams/1.json
  def destroy
    @epsa_team.destroy
    respond_to do |format|
      format.html { redirect_to epsa_teams_url, notice: 'Epsa team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_epsa_team
      @epsa_team = EpsaTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def epsa_team_params
      params.require(:epsa_team).permit(:institution_id, :name, :previous_team_id)
    end
end
