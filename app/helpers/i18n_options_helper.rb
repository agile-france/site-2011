module I18nOptionsHelper
  def i18n_options(klass, method)
    prefix = i18n_prefix(klass)
    klass.send(method).map {|value| [t("#{prefix}.#{value}"), value]}
  end
  
  private
  def i18n_prefix(klass)
    klass.to_s.tableize.gsub('/','.')
  end
end