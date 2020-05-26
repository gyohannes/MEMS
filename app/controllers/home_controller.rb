class HomeController < BaseController
  add_breadcrumb "Dashboard", :root_path

  def index
    @equipment = current_user.load_equipment
  end
end
