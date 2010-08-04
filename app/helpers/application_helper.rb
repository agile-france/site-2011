module ApplicationHelper
  def mark
    '*'
  end
  
  def required?(object, attribute)
    object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator  
  end
end
