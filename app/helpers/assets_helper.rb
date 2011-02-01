module AssetsHelper
  def icon_for(provider)
    provider, hint = domainize(provider)
    image_tag("https://github.com/intridea/authbuttons/raw/master/png/#{provider}_64.png", 
      :alt => hint, :title => hint)
  end
  
  def image_for(asset)
    term = File.basename(asset, File.extname(asset))
    hint = t("icons.#{term}")
    image_tag(asset, :alt => hint, :title => hint)
  end
  
  private
  def domainize(provider)
    case provider.to_sym
    when :google_apps
      [:google, 'Gmail']
    else
      [provider, provider.to_s.humanize]
    end
  end
end