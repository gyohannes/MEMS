class UsersController < BaseController
  layout 'application'
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update]

  def load
    @stores = current_user.organization_unit.try(:stores)
  end

  def load_departments
    @role = params[:role]
    org_unit = OrganizationUnit.find_by(id: params["org_unit"])
    @departments = org_unit.blank? ? [] : org_unit.departments
    render partial: 'department'
  end
  # GET /users
  # GET /users.json
  def index
    @type = params[:type]
    @users = User.load_users(current_user, @type)
  end

  def load_users
    @organization_unit  = OrganizationUnit.find(params[:node])
    @users = @organization_unit.sub_users
    render partial: 'users'
  end
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    unless params[:organization_unit].blank?
      @user.organization_unit_id = params[:organization_unit]
    end

    unless current_user.institution.blank?
      @user.institution_id = current_user.institution_id
      @institutions = [@user.institution]
    end
  end

  # GET /users/1/edit
  def edit
    unless @user.organization_unit.blank?
      @institutions = @user.organization_unit.institutions
    else
      @institutions = [@user.institution]
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
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
                                   :department_id, :store_id, :organization_unit_id, :facility_id, :institution_id, :role)
    end
end
