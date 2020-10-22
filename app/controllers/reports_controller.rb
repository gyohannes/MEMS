class ReportsController < ApplicationController
  add_breadcrumb "Home", :root_path

  def equipment
    add_breadcrumb "Equipment Report", :reports_equipment_path

    @equipment = []
    if request.post?
      statuses = params[:search][:status].reject{|x| x.blank?}
      @equipment = Equipment.search(params[:search][:equipment_name],params[:search][:organization_unit], params[:search][:type],
                                    params[:search][:model], statuses, current_user, params[:search][:inventory_number],
                                    params[:search][:from], params[:search][:to], params[:search][:acquisition_type])
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  def trainings
    add_breadcrumb "Trainings Report", :reports_trainings_path

    @trainings = []
    if request.post?
      types = params[:search][:training_type].reject{|x| x.blank?} if params[:search][:training_type]
      levels = params[:search][:training_level].reject{|x| x.blank?} if params[:search][:training_level]
      @trainings = Training.search(params[:search][:organization_unite], params[:search][:quipment_name],
                                   params[:search][:type],params[:search][:model],
                                   types, levels, current_user, params[:search][:from], params[:search][:to])
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  def maintenances
    add_breadcrumb "Maintenances Report", :reports_maintenances_path

    @maintenances = []
    if request.post?
      types = params[:search][:maintenance_type].reject{|x| x.blank?} if params[:search][:maintenance_type]
      @maintenances = Maintenance.search(params[:search][:organization_unit], params[:search][:quipment_name], params[:search][:model],
                                   types, current_user, params[:search][:from], params[:search][:to])
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  def spare_parts
    add_breadcrumb "Spare Parts Report", :reports_spare_parts_path
    @spare_parts = current_user.organization_unit.spare_parts
    if request.post?
      @spare_parts = SparePart.search(params[:search][:organization_unit], params[:search][:equipment_name], params[:search][:spare_part_name],
                                         current_user, params[:search][:from], params[:search][:to])
      respond_to do |format|
        format.js
        format.html
      end
    end
  end


  def disposals
    add_breadcrumb "Disposals Report", :reports_disposals_path
  @disposals = []
  if request.post?
    reasons = params[:search][:disposal_reason].reject{|x| x.blank?} if params[:search][:disposal_reason]
    methods = params[:search][:disposal_method].reject{|x| x.blank?} if params[:search][:disposal_method]
    @disposals = Disposal.search(params[:search][:organization_unit], params[:search][:equipment_type],reasons, methods, current_user, params[:search][:from], params[:search][:to])
    respond_to do |format|
      format.js
      format.html
    end
  end
  end

  def load_models
    equipment_name  = params[:equipment_name]
    @models = Equipment.unscoped.where('equipment_name_id = ?', equipment_name).pluck(:model)
    render partial: 'model'
  end

end
