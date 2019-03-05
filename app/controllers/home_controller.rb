class HomeController < BaseController

  def index
    @equipment = current_user.load_equipment
  end
end
