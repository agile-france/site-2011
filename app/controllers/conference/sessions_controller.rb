class Conference::SessionsController < ApplicationController
  before_filter :authenticate_user!, :except => :index
  respond_to :html, :json

  def new
    @session = Session.new
    respond_with @session
  end

  def create
    @session = Session.new(params[:session])
    flash[:notice] = t('conference.session.new.success!') if @session.save
    respond_with @session, :location => root_path
  end

  def index
    @sessions = Session.all
    respond_with @sessions
  end
end
