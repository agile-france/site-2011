class RatingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    authorize! :vote, current_session
  end

  def create
    respond_to_format(rating.save)
  end

  def update
    respond_to_format(rating.save)
  end

  private
  def rating
    @rating ||= current_user.rate(current_session, params[:rating])
  end
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