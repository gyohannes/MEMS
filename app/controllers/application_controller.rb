class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html, :js, :json
  before_action :set_institution
  before_action :load_notifications

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end

  private

  def set_institution
    @institution = current_user.institution rescue nil
  end

  def load_notifications
    @all_notifications = []
    if current_user
      if current_user.is_role(Constants::BIOMEDICAL_HEAD)
        @all_notifications = current_user.organization_unit.notifications
      elsif current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
        @all_notifications = current_user.notifications
      elsif current_user.is_role(Constants::DEPARTMENT)
        @all_notifications = current_user.department.notifications
      end
      @all_notifications = @all_notifications.select{|x| !x.read(current_user.id)}
    end
    return @all_notifications
  end

end
