require 'digest/md5'

module AvatarHelper
  def avatar_for(user, options={})
    image_tag(user.avatar.last, {:size => '69x69'}.merge(options))
  end
  
  def avatar_hint(user)
    Markdown.new(t('account.gravatar')).to_html if user.avatar.first === :gravatar
  end
end
