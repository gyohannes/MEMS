class HomeController < BaseController
  add_breadcrumb "Dashboard", :root_path

  def index
    @deps = Department.joins(:equipment).where('equipment.organization_unit_id = ?', current_user.organization_unit_id).uniq
  end
end
