class UserDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def full_name
    if first_name.blank? && father_name.blank? && grand_father_name.blank?
      'No name provided'
    else
    " #{first_name} #{father_name} #{grand_father_name}".strip
    end
  end

end
