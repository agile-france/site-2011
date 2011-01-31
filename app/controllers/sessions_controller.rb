class SessionsController < ApplicationController
  # filters
  # 1. authentication, for Create, Update
  # 2. authorization, for Update
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authorize_user!, :only => [:edit, :update]
  cant do
    not current_session.user == current_user
  end

  # supported formats
  respond_to :html, :json
  
  def new
    @session = Session.new
    respond_with @session
  end

  def create
    @session = Session.new(params[:session])
    current_user.propose(@session, current_conference)
    flash[:notice] = t('sessions.new.success!') if @session.save
    respond_with @session, :location => current_conference
  end

  def show
    respond_with current_session
  end

  def edit
    respond_with current_session
  end

  def update
    if current_session.update_attributes(params[:session])
      flash[:notice] = t('sessions.update.success!')
    end
    respond_with current_session, :location => awesome_session_path(current_session)
  end

  def index
    @sessions = current_conference.sessions
    respond_with @sessions
  end

  private  
  def current_session
    @session ||= Session.find(params[:id])
  end
  
  # looks like this current_#{symbol} is a pattern
  # is it a good one ?, dunno at this time ... and looks like symbol requested in params is a pain
  def current_conference
    @conference ||= Conference.find(params[:conference_id])
  end
end