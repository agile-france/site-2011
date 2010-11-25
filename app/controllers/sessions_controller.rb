class SessionsController < ApplicationController
  # filters
  # 1. authentication, for Create, Update
  # 2. authorization, for Update
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authorize_user!, :only => [:edit, :update]

  # supported formats
  respond_to :html, :json
  
  def new
    @session = Session.new
    respond_with @session
  end

  def create
    @session = Session.new(params[:session])
    current_user.propose(@session, current_conference)
    flash[:notice] = t('party.session.new.success!') if @session.save
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
      flash[:notice] = t('party.session.update.success!')
    end
    respond_with current_session, :location => current_session
  end

  def index
    @sessions = current_conference.sessions
    respond_with @sessions
  end

  helper_method :can_edit?, :current_session  
  private
  def can_edit?(user, session)
    user == session.user
  end
  
  def current_session
    @session ||= Session.find(params[:id])
  end
  
  # looks like this current_#{symbol} is a pattern
  # is it a good one ?, dunno at this time ... and looks like symbol requested in params is a pain
  def current_conference
    @conference ||= Conference.find(params[:conference_id])
  end

  # cancan is an option
  def authorize_user!
    raise Failures::AccessDenied.new(t('resources.not_authorized')) if cannot? :edit, current_session
  end
end