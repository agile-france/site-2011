module RatingsHelper
  include ApplicationHelper
  def rating_id_for(rated)
    "#{id_for_resource(rated)}_rating"
  end
  
  def rating_link_for(rating, rating_as_hash)
    stars = rating_as_hash[:stars]
    path, options = if rating.new_record?
      [awesome_session_ratings_path(rating.session, :rating => rating_as_hash), {:method => :post}]
    else
      [awesome_session_rating_path(rating.session, rating, :rating => rating_as_hash), {:method => :put}]
    end
    image = (rating.stars < stars ? 'star_transparent.png' : 'star_colored.png')
    hint = hint_for(stars)
    options.merge!('data-stars' => stars)    
    options.merge!(:remote => true) if user_signed_in?
    link_to image_tag(image, :alt => hint, :title => hint, :size => '12x12'), path, options
  end
  
  private
  def hint_for(stars)
    t("constants.stars.#{stars}")
  end
end