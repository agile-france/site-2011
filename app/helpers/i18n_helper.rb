module I18nHelper
  def i18n_options_for(klass, method=:all)
    prefix = i18n_prefix_for(klass)
    klass.send(method).map {|value| [t("#{prefix}.#{value}"), value]}
  end

  def i18n_text_for(resource, field)
    t(infered_i18n_key_for(resource, field)) unless resource.send(field).blank?
  end

  private
  def i18n_prefix_for(klass)
    klass.to_s.tableize.gsub('/','.')
  end
  def infered_i18n_key_for(resource, field)
    "constants.#{resource.class.to_s.tableize}.#{field.to_s.tableize}.#{resource.send(field)}"
  end
end