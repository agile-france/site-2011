class RatingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user!
  cant do |action, resource = current_session()|
    resource.user == current_user
  end.die {raise Cant::AccessDenied.new(I18n.translate('sessions.ratings.denied'))}
  
  def create
    @rating = current_user.rate(current_session, params[:rating])
    respond_to_format(@rating.save)
  end
  
  def update
    @rating = current_user.rate(current_session, params[:rating])
    respond_to_format(@rating.save)
  end
  
  private
  def current_session
    @session ||= Session.find(params[:awesome_session_id])
  end
  def respond_to_format(saved)
    flash[:notice] = t('sessions.ratings.greetings', :stars => @rating.stars,
      :session => current_session.title) if saved
    respond_to do |format|
      format.html {saved ? redirect_to(awesome_session_path(current_session)) : render('sessions/show')}
      format.js {render 'ratings/rate'}
    end    
  end
end