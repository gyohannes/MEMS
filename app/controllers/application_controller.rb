class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html, :js, :json
  before_action :load_notifications

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end

  private

  def load_notifications
    @all_notifications = []
    if current_user
      if current_user.is_role(Constants::BIOMEDICAL_HEAD)
        @all_notifications = current_user.organization_unit.notifications.includes(:notification_user_visits)
                                 .where(notification_user_visits: {user_id: nil} )
                                 .order('notifications.created_at DESC')
      elsif current_user.is_role(Constants::BIOMEDICAL_ENGINEER)
        @all_notifications = current_user.notifications.includes(:notification_user_visits)
                                 .where(notification_user_visits: {user_id: nil})
                                 .order('notifications.created_at DESC')
      elsif current_user.is_role(Constants::DEPARTMENT)
        @all_notifications = current_user.department.notifications.joins(:notification_user_visits)
                                 .where(notification_user_visits: {user_id: nil})
                                 .order('notifications.created_at DESC')
      end
    end
    return @all_notifications
  end

end
