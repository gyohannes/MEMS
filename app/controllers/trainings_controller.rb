class TrainingsController < ApplicationController
  before_action :set_training, only: [:show, :edit, :update, :destroy]

  # GET /trainings
  # GET /trainings.json
  def index
    @trainings = Training.where('contact_id in (?)', current_user.load_contacts.pluck(:id))
  end

  # GET /trainings/1
  # GET /trainings/1.json
  def show
  end

  # GET /trainings/new
  def new
    @training = Training.new
    @training.build_contact
    equipment = Equipment.find_by_id(params[:equipment])
    @training.equipment_name = equipment.equipment_name rescue nil
    @training.model = equipment.model rescue nil
    session[:return_to] = request.referer
  end

  # GET /trainings/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /trainings
  # POST /trainings.json
  def create
    contact = Contact.find_by(name_of_contact: params[:training][:contact_attributes][:name_of_contact],
                              phone_number: params[:training][:contact_attributes][:phone_number])
    unless contact.blank?
      params[:training][:contact_id] = contact.id
      params[:training].delete('contact_attributes')
    end
    @training = Training.new(training_params)
    respond_to do |format|
      if @training.save
        format.html { redirect_to session.delete(:return_to), notice: 'Training was successfully created.' }
        format.json { render :show, status: :created, location: @training }
      else
        format.html { render :new }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainings/1
  # PATCH/PUT /trainings/1.json
  def update
    contact = Contact.find_by(name_of_contact: params[:training][:contact_attributes][:name_of_contact],
                              phone_number: params[:training][:contact_attributes][:phone_number])

    unless contact.blank?
      params[:training][:contact_id] = contact.id
    end
    params[:training].delete('contact_attributes')

    respond_to do |format|
      if @training.update(training_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Training was successfully updated.' }
        format.json { render :show, status: :ok, location: @training }
      else
        format.html { render :edit }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trainings/1
  # DELETE /trainings/1.json
  def destroy
    @training.destroy
    respond_to do |format|
      format.html { redirect_to trainings_url, notice: 'Training was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_params
      params.require(:training).permit(:contact_id, :equipment_name, :model, :training_type, :trainer_name, :training_sponsor, :training_date,
      contact_attributes: [:id, :facility_id, :organization_unit_id, :name_of_contact, :profession, :title, :work_place, :city, :phone_number, :country, :email, :_destroy])
    end
end
