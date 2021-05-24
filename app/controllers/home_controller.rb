class HomeController < BaseController

  def index
    @deps = Department.joins(:equipment).where('equipment.organization_unit_id = ?', current_user.organization_unit_id).uniq
    @equipment = current_user.is_role(Constants::DEPARTMENT) ? current_user.load_equipment : []
  end
end
