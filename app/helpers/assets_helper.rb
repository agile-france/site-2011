module AssetsHelper
  def icon_for(provider)
    hint = provider.to_s.humanize
    image_tag("https://github.com/intridea/authbuttons/raw/master/png/#{provider}_64.png", 
      :alt => hint, :title => hint)
  end
end