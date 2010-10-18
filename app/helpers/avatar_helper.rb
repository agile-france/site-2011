require 'digest/md5'

module AvatarHelper
  def gravatar_for(user, options={})
    image_tag("http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", 
      {:size => '40x40'}.merge(options))
  end
end