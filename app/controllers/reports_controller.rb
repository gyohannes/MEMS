class ReportsController < ApplicationController
  def equipment
    @equipment = []
    if request.post?
      statuses = params[:search][:status].reject{|x| x.blank?}
      @equipment = Equipment.search(params[:search][:equipment_name],params[:search][:organization_unit],
                                    params[:search][:type], params[:search][:model], statuses, current_user,
                                    params[:search][:inventory_number])
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  def trainings
    @trainings = []
    if request.post?
      types = params[:search][:training_type].reject{|x| x.blank?}
      @trainings = Training.search(params[:search][:equipment_name], params[:search][:organization_unit],
                                   params[:search][:type],params[:search][:model], types)
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  def load_facilities
    org_structure = OrganizationUnit.find_by(id: params[:organization_unit])
    @facilities = org_structure.sub_facilities
    render partial: 'facility'
  end

end
