class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]
  before_action :load_spare_parts, only: [:new, :create, :edit, :update]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Item Issues", :issues_path

  def load_spare_parts
    @spare_parts = current_user.organization_unit.spare_parts
  end
  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    add_breadcrumb "Details", :issue_path
  end

  # GET /issues/new
  def new
    add_breadcrumb "New", :new_issue_path
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
    add_breadcrumb "Edit", :edit_issue_path
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:store_id, :reference_number, :issue_date, :issued_by, :received_by,
                                    issue_spare_parts_attributes: [:id, :issue_id, :spare_part_id, :quantity, :remarks, :_destroy])
    end
end
