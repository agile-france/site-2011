class SessionsController < ApplicationController
  # filters
  # 1. authentication, for Create, Update
  # 2. authorization, for Update
  before_filter :authenticate_user!, :except => [:show]
  before_filter :authorize_user!, :only => [:edit, :update, :destroy, :index]
  cant do |action|
    return false if action == :show
    if action == :index
      not current_user.admin?
    else
      current_user.nil? or not (current_user.admin? or current_session.user == current_user)
    end
  end

  # supported formats
  respond_to :html, :json
  
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(params[:session])
    if current_user.propose(@session, current_conference)
      redirect_to conference_path(current_conference), :notice => t('sessions.new.success!') 
    else
      render :new
    end
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
    @sessions = Session.all.desc(:created_at).paginate(pager_options)
  end

  def destroy
    @session = current_session
    @session.destroy
    redirect_to sessions_account_path unless request.xhr?
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