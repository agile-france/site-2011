module ApplicationHelper
  def mark
    '*'
  end
  
  def required?(object, attribute)
    object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator  
  end
  
  def id_for_resource(resource)
    "#{resource.class.to_s.tableize.singularize}_#{resource.id}"
  end

  def markdown(string)
    Markdown.new(string).to_html if string
  end
end
