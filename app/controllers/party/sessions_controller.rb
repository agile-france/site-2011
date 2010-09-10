class Party::SessionsController < ApplicationController
  before_filter :authenticate_user!, :except => :index
  respond_to :html, :json

  def new
    @session = Party::Session.new
    respond_with @session
  end

  def create
    @session = Party::Session.new(params[:session])
    flash[:notice] = t('party.session.new.success!') if @session.save
    respond_with @session, :location => root_path
  end

  def index
    @sessions = Party::Session.all
    respond_with @sessions
  end
end
