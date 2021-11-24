class UsersController < BaseController
  load_and_authorize_resource
  layout 'application'
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Users", :users_path

  def load
    @hubs = EpsaHub.all
    @roles = current_user.organization_unit ? Constants::ROLES : ['Supplier','Hub']
    @stores = current_user.organization_unit.try(:stores)
    @org_units = current_user.organization_unit.sub_units + [current_user.organization_unit] rescue nil
  end

  def load_departments
    @role = params[:role]
    @hubs = EpsaHub.all
    @departments = current_user.organization_unit.departments rescue nil
    render partial: 'department'
  end
  # GET /users
  # GET /users.json
  def index
    @org_unit_users = current_user.organization_unit.sub_users rescue nil
    @other_users = User.includes(:organization_unit).where(organization_units: {id: nil})
  end

  def load_users
    @organization_unit  = OrganizationUnit.find(params[:node])
    @org_unit_users = @organization_unit.sub_users
    render partial: 'users'
  end
  # GET /users/1
  # GET /users/1.json
  def show
    add_breadcrumb "Details", :user_path
  end

  # GET /users/new
  def new
    add_breadcrumb "New", :new_user_path
    @user_type = params[:type]
    @user = User.new
    unless params[:organization_unit].blank?
      @user.organization_unit_id = params[:organization_unit]
    end

    unless current_user.institution.blank?
      @user.institution_id = current_user.institution_id
      @institutions = [@user.institution]
    else
      @institutions = Institution.all
    end
  end

  # GET /users/1/edit
  def edit
    @departments = current_user.organization_unit.departments rescue nil
    add_breadcrumb "Edit", :edit_user_path
    @role = @user.role
    @user_type = @user.user_type
    unless @user.organization_unit.blank?
      @institutions = @user.organization_unit.institutions
    else
      @institutions = [@user.institution]
    end
  end

  # POST /users
  # POST /users.json
  def create
    @departments = current_user.organization_unit.departments rescue nil
    @user = User.new(user_params)
    @role = @user.role
    unless @user.organization_unit.blank?
      @institutions = @user.organization_unit.institutions
    else
      @institutions = [@user.institution]
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    unless @user.organization_unit.blank?
      @institutions = @user.organization_unit.institutions
    else
      @institutions = [@user.institution]
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :father_name, :grand_father_name,
                                   :department_id, :epsa_hub_id, :store_id, :organization_unit_id, :user_type, :institution_id, :role)
    end
end
