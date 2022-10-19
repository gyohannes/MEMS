class EquipmentDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def manufactured_year
    unless manufactured_year.blank?
      object.manufactured_year.strftime("%Y")
    end
  end

  def purchased_year
    unless purchased_year.blank?
      object.purchased_year.strftime("%Y")
    end
  end

end
