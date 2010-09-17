module ApplicationHelper
  def mark
    '*'
  end
  
  def required?(object, attribute)
    object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator  
  end

  def markup(string)
    Markup.new(string).to_html
  end
end
