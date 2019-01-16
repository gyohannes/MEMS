class UsersController < BaseController
  layout 'application'
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :load, only: [:new, :create, :edit, :update]

  def load
    @stores = current_user.facility.try(:stores)
  end
  # GET /users
  # GET /users.json
  def index
    @type = params[:type]
    @users = User.load_users(current_user, @type)
  end

  def load_users
    @organization_structure  = OrganizationStructure.find(params[:node])
    @users = @organization_structure.sub_users
    render partial: 'users'
  end
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    unless params[:organization_structure].blank?
      @user.organization_structure_id = params[:organization_structure]
      @facilities = @user.organization_structure.facilities
      @institutions = @user.organization_structure.institutions
    end
    unless current_user.facility.blank?
      @user.facility_id = current_user.facility_id
      @facilities = [@user.facility]
    end

    unless current_user.institution.blank?
      @user.institution_id = current_user.institution_id
      @institutions = [@user.institution]
    end
  end

  # GET /users/1/edit
  def edit
    unless @user.organization_structure.blank?
      @facilities = @user.organization_structure.facilities
      @institutions = @user.organization_structure.institutions
    else
      @facilities = [@user.facility]
      @institutions = [@user.institution]
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    unless @user.organization_structure.blank?
      @facilities = @user.organization_structure.facilities
      @institutions = @user.organization_structure.institutions
    else
      @facilities = [@user.facility]
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
    unless @user.organization_structure.blank?
      @facilities = @user.organization_structure.facilities
      @institutions = @user.organization_structure.institutions
    else
      @facilities = [@user.facility]
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
                                   :department_id, :store_id, :organization_structure_id, :facility_id, :institution_id, :role)
    end
end
