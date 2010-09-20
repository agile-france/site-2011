class SessionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authorize_user!, :only => [:edit, :update]

  respond_to :html, :json

  def new
    @session = Session.new
    respond_with @session
  end

  def create
    @session = Session.new(params[:session])
    current_user.propose(@session, current_conference)
    flash[:notice] = t('party.session.new.success!') if @session.save
    respond_with @session, :location => conference_sessions_path(@conference)
  end

  def show
    respond_with current_session
  end

  def edit
    respond_with current_session
  end

  def update
    if current_session.update_attributes(params[:session])
      flash[:notice] = t('party.session.update.success!')
    end
    respond_with current_session,
                 :location => conference_session_path(current_session.conference, current_session)
  end

  def index
    @sessions = current_conference.sessions
    respond_with @sessions
  end

  private
  # looks like this current_#{symbol} is a pattern
  # is it a good one ?, dunno at this time ... and looks like symbol requested in params is a pain
  def current_conference
    @conference ||= Conference.find(params[:conference_id])
  end

  def current_session
    @session ||= Session.find(params[:id])
  end

  # cancan is an option
  def authorize_user!
    unless can_edit?(current_user, current_session)
      raise Failures::AccessDenied.new("#{current_user.greeter_name} can not edit #{current_session.title}")
    end
  end

  def can_edit?(user, session)
    user == session.user
  end
end